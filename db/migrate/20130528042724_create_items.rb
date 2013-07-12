class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :author
      t.integer :medium
      t.string :pubinfo
      t.date :checkout

      t.timestamps
    end
  end
end
