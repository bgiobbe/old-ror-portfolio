# == Schema Information
#
# Table name: resources
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  author     :string(255)
#  medium     :integer
#  pubinfo    :string(255)
#  checkout   :date
#  created_at :datetime
#  updated_at :datetime
#

class Resource < ActiveRecord::Base
  BOOK = 1
  AUDIO = 2
  VIDEO = 3
  MEDIA_DESC = { BOOK => "Book", AUDIO => "Audio", VIDEO => "Video" }
  MEDIA_OPTIONS = [ ["Book", BOOK], ["Audio", AUDIO], ["Video", VIDEO] ] 
  
  validates_presence_of :title, :checkout, :medium
  validate :medium_is_recognized
  
  # Return true if medium is valid, false otherwise
  def self.is_medium?(value)
    [ BOOK, AUDIO, VIDEO ].include?(value.class == String ? value.to_i : value)
  end

  private

  def medium_is_recognized
    errors.add(:medium, "unrecognized medium") unless
      [ BOOK, AUDIO, VIDEO ].include? medium
  end
end
