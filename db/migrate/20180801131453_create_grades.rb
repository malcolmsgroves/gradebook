class CreateGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :grades do |t|
      t.integer :student_id, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.decimal :grade

      t.timestamps
    end
  end
end
