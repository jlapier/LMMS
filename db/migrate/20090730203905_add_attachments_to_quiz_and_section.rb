class AddAttachmentsToQuizAndSection < ActiveRecord::Migration
  def self.up
    add_column :sections, :layout_image_file_name, :string
    add_column :sections, :layout_image_content_type, :string
    add_column :sections, :layout_image_file_size, :integer
    add_column :sections, :layout_image_updated_at, :datetime
    add_column :sections, :layout_image_alt_text, :string

    add_column :quiz_pages, :layout_image_file_name, :string
    add_column :quiz_pages, :layout_image_content_type, :string
    add_column :quiz_pages, :layout_image_file_size, :integer
    add_column :quiz_pages, :layout_image_updated_at, :datetime
    add_column :quiz_pages, :layout_image_alt_text, :string
  end

  def self.down
    remove_column :sections, :layout_image_file_name
    remove_column :sections, :layout_image_content_type
    remove_column :sections, :layout_image_file_size
    remove_column :sections, :layout_image_updated_at
    remove_column :sections, :layout_image_alt_text

    remove_column :quiz_pages, :layout_image_file_name
    remove_column :quiz_pages, :layout_image_content_type
    remove_column :quiz_pages, :layout_image_file_size
    remove_column :quiz_pages, :layout_image_updated_at
    remove_column :quiz_pages, :layout_image_alt_text
  end

end
