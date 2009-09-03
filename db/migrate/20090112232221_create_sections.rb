class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.integer :learning_module_id
      t.integer :position
      t.string :title
    end
  end

  def self.down
    drop_table :sections
  end
end
