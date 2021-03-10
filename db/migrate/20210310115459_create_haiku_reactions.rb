class CreateHaikuReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :haiku_reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :haiku, null: false, foreign_key: true

      t.timestamps
    end
    add_index :haiku_reactions, [:user_id, :haiku_id], unique: true
  end
end
