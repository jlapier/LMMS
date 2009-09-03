class AddDescriptionToLearningModules < ActiveRecord::Migration
  def self.up
    add_column :learning_modules, :description, :text
  end

  def self.down
    remove_column :learning_modules, :description
  end
end
