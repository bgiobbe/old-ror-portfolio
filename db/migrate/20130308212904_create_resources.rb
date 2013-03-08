class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.string :title
      t.string :author
      t.integer :medium
      t.string :pubinfo
      t.date :checkout

      t.timestamps
    end
  end

  def self.down
    drop_table :resources
  end
end
