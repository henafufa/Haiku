class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.text :message
      t.text :notification_type
      t.references :user, null: false, foreign_key: true
      t.references :haiku_reaction, null: true, foreign_key: true
      t.references :haiku_comment, null: true, foreign_key: true
      t.references :challenge_user, null: true, foreign_key: true
      t.references :relationship, null: true, foreign_key: true
      t.boolean :is_seen, defualt: false

      t.timestamps
    end
  end
end
