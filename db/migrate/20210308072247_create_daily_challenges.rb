class CreateDailyChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_challenges do |t|
      t.references :user, null: false, foreign_key: true
      t.references :haiku, null: false, foreign_key: true
      t.boolean :postStatus
      t.datetime :thirtyDates

      t.timestamps
    end
    add_index :daily_challenges, [:user_id, :haiku_id, :created_at]
  end
end
