class CreateLakatanTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :lakatan_teams do |t|
      t.string :name
      t.string :purpose
      t.text :task_ids
      t.text :user_ids

      t.timestamps
    end
  end
end
