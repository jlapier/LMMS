class CreateSitePages < ActiveRecord::Migration
  def self.up
    create_table :site_pages do |t|
      t.string :title
      t.integer :position
      t.text :body
      t.string :layout_image_file_name
      t.string :layout_image_content_type
      t.integer :layout_image_file_size
      t.datetime :layout_image_updated_at
      t.string :layout_image_alt_text

      t.timestamps
    end
  end

  def self.down
    drop_table :site_pages
  end
end
