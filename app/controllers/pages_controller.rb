class PagesController < ApplicationController

  def index
    render :layout => false
  end
  
  def interests
    @crochet_pics = [
      ['/images/crochet/flower_garden_tn.jpg', 'Grandma\'s Flower Garden quilt',
       'Grandma\'s Flower Garden, an afghan based on a quilt pattern'],
      ['/images/crochet/mikes_triangles_tn.jpg', 'Triangles afghan',
       "Triangles afghan, also based on a quilt pattern"],
      ['/images/crochet/maddies_stripes_tn.jpg', 'Striped throw',
       'Colorful striped throw, for my niece'],
      ['/images/crochet/melonberry_maize_tn.jpg',
        'Melonberry/maize skinny scarf',
        'A skinny scarf - melonberry with maize border'],
     # ['/images/crochet/zebra_burgundy_tn.jpg', 'Zebra/burgundy skinny scarf',
     #   'Zebra skinny scarf with burgundy border'],
      ['/images/crochet/scarves.png', 'Skinny scarves',
        'Skinny scarves in an array of colors - for sale on Etsy.com!']
    ]
  end

  def resume
  end
  
  def vision
  end
  
end
