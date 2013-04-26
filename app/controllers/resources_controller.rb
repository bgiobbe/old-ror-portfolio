
class ResourcesController < ApplicationController
  helper_method :sort_column, :sort_direction, :items_per_page
  
  # GET /resources
  # GET /resources.xml
  def index
    require 'will_paginate'
    respond_to do |format|
      format.html { # index.html.erb
        @title = 'Library History'
        @resources = Resource.paginate(
            :page => page_number, :per_page => items_per_page,
            :order => sort_column + " " + sort_direction
        )
        @count = Resource.count        
      }
      format.xml  {
        @resources = Resource.all
        render :xml => @resources
      }
    end
  end

  def search
    require 'will_paginate'
    condition = ["author LIKE ?", "%%%s%%" % params[:q]]
    @title = 'Search Results'
    @resources = Resource.paginate(
      :conditions => condition,
      :page => page_number, :per_page => items_per_page,
      :order => sort_column + " " + sort_direction
    )
    @count = Resource.count(:conditions => condition)
    render 'index'
  end
  
  # GET /resources/1
  # GET /resources/1.xml
  def show
    @resource = Resource.find(params[:id])

    respond_to do |format|
      format.html { # show.html.erb
        @title = 'Library Item'
      }
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/new
  # GET /resources/new.xml
  def new
    @resource = Resource.new
    @media_options = Resource::MEDIA_OPTIONS
    @submit_text = 'Create'

    respond_to do |format|
      format.html { # new.html.erb
        @title = 'Add Library Items'
      }
      format.xml  { render :xml => @resource }
    end
  end

  # Upload resources from a tab-separated text file
  # Headers: Title  Author  Pub Info  Checked Out
  def upload_tsv
    require 'fastercsv'
    begin
      input = FasterCSV::new(params[:tsv_file], :col_sep => "\t",
        :quote_char => "`", :headers => true, :header_converters => :symbol)
      # quote_char option prevents errors when a field contains quotation marks
      
      input.each do |row|
        title, medium = extractTitleMediumFromTSV(row[:title])
        checkout = Date.strptime(row[:checked_out], '%m-%d-%Y')
        Resource.create(
            :title => title,
            :author => row[:author],
            :medium => medium,
            :pubinfo => row[:pub_info],
            :checkout => checkout
        )
      end
      
    ensure
      input.close unless input.nil?
    end
    redirect_to resources_path
  end
  
  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
    @media_options = Resource::MEDIA_OPTIONS
    @submit_text = 'Update'
    @title = 'Edit Library Item'
  end

  # POST /resources
  # POST /resources.xml
  def create
    @resource = Resource.new(params[:resource])

    respond_to do |format|
      if @resource.save
        format.html { redirect_to(@resource, :notice => 'Resource was successfully created.') }
        format.xml  { render :xml => @resource, :status => :created, :location => @resource }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resources/1
  # PUT /resources/1.xml
  def update
    @resource = Resource.find(params[:id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        format.html { redirect_to(@resource, :notice => 'Resource was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.xml
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to(resources_url) }
      format.xml  { head :ok }
    end
  end

  private
  
  # Parse the title and medium from the title field of the tab-separated file
  # Expected string formats:
  #   "Title [videorecording] / ..."
  #   "Title [sound recording] / ..."
  #   "Title / Author"
  def extractTitleMediumFromTSV(string)
    case string
    when /\A(.+)\s\[videorecording\]/
      [$1, Resource::VIDEO]
    when /\A(.+)\s\[sound recording\]/
      [$1, Resource::AUDIO]
    when /\A(.+)\s\//
      [$1, Resource::BOOK]
    else
      [string, Resource::BOOK]
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
end
