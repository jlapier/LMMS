class CreateLearningModules < ActiveRecord::Migration
  def self.up
    create_table :learning_modules do |t|
      t.string :title
      t.integer :position
    end
  end

  def self.down
    drop_table :learning_modules
  end
end
