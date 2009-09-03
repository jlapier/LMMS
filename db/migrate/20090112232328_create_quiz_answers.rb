class CreateQuizAnswers < ActiveRecord::Migration
  def self.up
    create_table :quiz_answers do |t|
      t.integer :quiz_question_id
      t.text :body

      t.timestamps
    end
    add_index :quiz_answers, :quiz_question_id
  end

  def self.down
    drop_table :quiz_answers
  end
end
