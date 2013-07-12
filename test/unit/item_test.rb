require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should save a BOOK" do
    item = Item.new(
      :title => "A Title",
      :checkout => Date.today(),
      :medium => Item::BOOK)
    assert item.save
  end
  
  test "should save an AUDIO item" do
    item = Item.new(
      :title => "A Title",
      :checkout => Date.today(),
      :medium => Item::AUDIO)
    assert item.save
  end
  
  test "should save a VIDEO item" do
    item = Item.new(
      :title => "A Title",
      :checkout => Date.today(),
      :medium => Item::VIDEO)
    assert item.save
  end

  # Sad cases
  
  test "should not save item without title" do
    item = Item.new(
      :checkout => Date.today(),
      :medium => Item::BOOK
    )
    assert !item.save
  end
  
  test "should not save item without checkout date" do
    item = Item.new(
      :title => "A Title",
      :medium => Item::BOOK)
    assert !item.save
  end
  
  test "should not save item without medium" do
    item = Item.new(
      :title => "A Title",
      :checkout => Date.today()
    )
    assert !item.save
  end
  
  test "should not save item with invalid medium" do
    item = Item.new(
      :title => "A Title",
      :checkout => Date.today(),
      :medium => 4
    )
    assert !item.save
  end
end
