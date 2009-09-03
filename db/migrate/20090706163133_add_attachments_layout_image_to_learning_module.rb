class AddAttachmentsLayoutImageToLearningModule < ActiveRecord::Migration
  def self.up
    add_column :learning_modules, :layout_image_file_name, :string
    add_column :learning_modules, :layout_image_content_type, :string
    add_column :learning_modules, :layout_image_file_size, :integer
    add_column :learning_modules, :layout_image_updated_at, :datetime
    add_column :learning_modules, :layout_image_alt_text, :string
  end

  def self.down
    remove_column :learning_modules, :layout_image_file_name
    remove_column :learning_modules, :layout_image_content_type
    remove_column :learning_modules, :layout_image_file_size
    remove_column :learning_modules, :layout_image_updated_at
    remove_column :learning_modules, :layout_image_alt_text
  end
end
