class ConcoursController < ApplicationController

  def index
    # [ [display_name, filename], ... ]
    @sample_code_items = [
      ['app/helpers/application_helper.rb', 'application_helper.rb.txt'],
      ['app/controllers/courses_controller.rb', 'courses_controller.rb.txt'],
      ['app/views/courses/index.html.erb', 'courses_index.html.erb'],
      ['app/views/courses/_course.html.erb', '_course.html.erb'],
      ['app/views/courses/show.html.erb', 'courses_show.html.erb'],
      ['app/controllers/students_controller.rb', 'students_controller.rb.txt'],
      ['app/views/students/index.html.erb', 'students_index.html.erb'],
      ['app/views/students/_index_toolbar.html.erb', '_index_toolbar.html.erb'],
      ['app/views/students/_student.html.erb', '_student.html.erb']
    ]
  end

  # Display source code file
  def show_code
    File.open("#{RAILS_ROOT}/public/sample_code/" + params[:filepath], 'r') do |file|
      @code = file.read
    end
    render :text => 
        "<p><a href='#{url_for(:action => 'index')}'>Back</a></p>" +
        "<pre style='font-size: 10px;'>#{@code}</pre>"
  end

end
