class CreateLakatanUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :lakatan_users do |t|
      t.string :name
      t.string :email
      t.string :slack_id
      t.string :personal_interview_url
      t.string :technical_interview_url
      t.integer :last_org
      t.text :team_ids
      t.json :dynamic_attributes, default: {}

      t.timestamps
    end
  end
end
