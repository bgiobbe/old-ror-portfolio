class PagesController < ApplicationController

  # GET /
  def index
    @no_navigation = true
  end
  
  # GET /pages/concours
  def concours
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
  
  # GET /pages/interests
  def interests
    @crochet_pics = [
      ['crochet/flower_garden_tn.jpg', 'Grandma\'s Flower Garden quilt',
       'Grandma\'s Flower Garden, an afghan based on a quilt pattern'],
      ['crochet/mikes_triangles_tn.jpg', 'Triangles afghan',
       "Triangles afghan, also based on a quilt pattern"],
      ['crochet/maddies_stripes_tn.jpg', 'Striped throw',
       'Colorful striped throw, for my niece'],
      ['crochet/melonberry_maize_tn.jpg',
        'Melonberry/maize skinny scarf',
        'A skinny scarf - melonberry with maize border'],
      ['crochet/scarves.png', 'Skinny scarves',
        'Skinny scarves in an array of colors - for sale on Etsy.com!']
    ]
  end

  # GET /pages/resume
  def resume
  end
  
  # GET /pages/vision
  def vision
  end
  
end
