class CreateQuizQuestions < ActiveRecord::Migration
  def self.up
    create_table :quiz_questions do |t|
      t.integer :quiz_page_id
      t.string :title
      t.integer :position
      t.text :body
      t.text :explanation
      t.integer :correct_answer_id

      t.timestamps
    end
    add_index :quiz_questions, :quiz_page_id
  end

  def self.down
    drop_table :quiz_questions
  end
end
