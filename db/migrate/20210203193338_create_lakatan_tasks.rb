class CreateLakatanTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :lakatan_tasks do |t|
      t.string :name
      t.string :goal
      t.string :raffle_type
      t.integer :label_id
      t.references :team, null: false, foreign_key: true
      t.integer :user_minimum

      t.timestamps
    end
  end
end
