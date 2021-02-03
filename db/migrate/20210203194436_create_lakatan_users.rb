class CreateLakatanUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :lakatan_users do |t|
      t.string :name
      t.string :email
      t.integer :last_org
      t.text :team_ids

      t.timestamps
    end
  end
end
