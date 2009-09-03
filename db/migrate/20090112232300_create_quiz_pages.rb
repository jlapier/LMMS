class CreateQuizPages < ActiveRecord::Migration
  def self.up
    create_table :quiz_pages do |t|
      t.integer :section_id
      t.string :title
      t.integer :position
      t.text :setup_body

      t.timestamps
    end
    add_index :quiz_pages, :section_id
  end

  def self.down
    drop_table :quiz_pages
  end
end
