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

require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
  # Happy cases
  
  test "should save a BOOK" do
    resource = Resource.new(
      :title => "A Title",
      :checkout => Date.today(),
      :medium => Resource::BOOK)
    assert resource.save
  end
  
  test "should save an AUDIO resource" do
    resource = Resource.new(
      :title => "A Title",
      :checkout => Date.today(),
      :medium => Resource::AUDIO)
    assert resource.save
  end
  
  test "should save a VIDEO resource" do
    resource = Resource.new(
      :title => "A Title",
      :checkout => Date.today(),
      :medium => Resource::VIDEO)
    assert resource.save
  end

  # Sad cases
  
  test "should not save resource without title" do
    resource = Resource.new(
      :checkout => Date.today(),
      :medium => Resource::BOOK
    )
    assert !resource.save
  end
  
  test "should not save resource without checkout date" do
    resource = Resource.new(
      :title => "A Title",
      :medium => Resource::BOOK)
    assert !resource.save
  end
  
  test "should not save resource without medium" do
    resource = Resource.new(
      :title => "A Title",
      :checkout => Date.today()
    )
    assert !resource.save
  end
  
  test "should not save resource with invalid medium" do
    resource = Resource.new(
      :title => "A Title",
      :checkout => Date.today(),
      :medium => 4
    )
    assert !resource.save
  end
end
