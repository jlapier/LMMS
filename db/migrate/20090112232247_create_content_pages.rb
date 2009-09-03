class CreateContentPages < ActiveRecord::Migration
  def self.up
    create_table :content_pages do |t|
      t.integer :section_id
      t.string :title
      t.integer :position
      t.text :main_body
      t.text :secondary_body

      t.timestamps
    end
    add_index :content_pages, :section_id
  end

  def self.down
    drop_table :content_pages
  end
end
