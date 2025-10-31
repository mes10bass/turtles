class CreateTodos < ActiveRecord::Migration[8.1]
  def change
    create_table :todos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.date :start_on
      t.date :end_on
      t.boolean :is_finished, null: false, default: false

      t.timestamps
    end
  end
end
