class CreateLakatanTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :lakatan_tasks do |t|
      t.string :name
      t.string :goal
      t.string :raffle_type
      t.integer :label_id
      t.bigint :team_id
      t.integer :user_minimum
      t.json :dynamic_attributes, default: {}

      t.timestamps
    end
  end
end
