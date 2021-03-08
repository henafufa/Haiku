class CreateDailyChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_challenges do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :postStatus, default: false
      t.datetime :thirtyDates

      t.timestamps
    end
    add_index :daily_challenges, [:user_id,:thirtyDates,  :created_at]
  end
  
end
