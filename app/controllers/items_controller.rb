class ItemsController < ApplicationController
  helper_method :sort_column, :sort_direction, :items_per_page
 
  # GET /items
  # GET /items.json
  def index
    respond_to do |format|
      format.html {  # index.html.erb
        require 'will_paginate'
        @title = 'Library History'
        @items = Item.paginate(
            :page => page_number, :per_page => items_per_page,
            :order => sort_column + " " + sort_direction
          )
          @media_options = Item::MEDIA_OPTIONS.insert(0, ["Any", 0])
      }
      format.json {
        @items = Item.all
        render json: @items
      }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html { # new.html.erb
        @media_options = Item::MEDIA_OPTIONS
        @submit_text = 'Create'
        @title = 'Add Library Items'
      }
      format.json { render json: @item }
    end
  end

  # GET /items/search
  def search
    require 'will_paginate'
    @title = 'Search Results'
    conditions = search_conditions
    @items = Item.paginate(
      :conditions => conditions,
      :page => 1, :per_page => items_per_page,
      :order => sort_column + " " + sort_direction
    )
    @count = Item.count(:conditions => conditions)
    @media_options = Item::MEDIA_OPTIONS.insert(0, ["Any", 0])
    render 'index'
  end
  
  # POST items/upload_tsv
  # Upload items from a tab-separated text file
  # Headers: Title  Author  Pub Info  Checked Out
  def upload_tsv
    require 'csv'
    # quote_char option prevents errors when a field contains quotation marks
    CSV.parse(params[:tsv_file].read, :col_sep => "\t", :quote_char => "`",
                :headers => true, :header_converters => :symbol) do |row|

      title, medium = extractTitleMediumFromTSV(row[:title])
      checkout = Date.strptime(row[:checked_out], '%m-%d-%Y')
      Item.create(
          :title => title,
          :author => row[:author],
          :medium => medium,
          :pubinfo => row[:pub_info],
          :checkout => checkout
      )

    end
    redirect_to items_path
  end
  
  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
  # Parse the title and medium from the title field of the tab-separated file
  # Expected string formats:
  #   "Title [videorecording] / ..."
  #   "Title [sound recording] / ..."
  #   "Title / Author"
  def extractTitleMediumFromTSV(string)
    case string
    when /\A(.+)\s\[videorecording\]/
      [$1, Item::VIDEO]
    when /\A(.+)\s\[sound recording\]/
      [$1, Item::AUDIO]
    when /\A(.+)\s\//
      [$1, Item::BOOK]
    else
      [string, Item::BOOK]
    end
  end
  
  # Return the number of items per page for the paginate query
  def items_per_page(default=25)
    params[:per_page].nil? || params[:per_page].empty? ?
        default : params[:per_page].to_i   
  end
  
  # Return the page number for the paginate query
  def page_number
    params[:page].nil? || params[:page].empty? ? 1 : params[:page]
  end
 
  # Return the column to sort by for the select query
  def sort_column
    %w[id medium title author pubinfo checkout].include?(params[:sort]) ?
        params[:sort] : "id"
  end
  
  # Return the direction to sort - ascending or descending -
  # for the select query
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
  # Create conditions array from search parameters
  def search_conditions
    strings, values = [], []
    if Item.is_medium? params[:medium]
      strings << "medium = ?"
      values << params[:medium]
    end
    if params[:author]
      strings << "author LIKE ?"
      values << "%%%s%%" % params[:author]
    end
    if params[:title]
      strings << "title LIKE ?"
      values << "%%%s%%" % params[:title]
    end
    [strings.join(" AND ")] + values
  end
end
