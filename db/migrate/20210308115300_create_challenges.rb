class CreateChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :challenges do |t|
      t.text :verse_1
      t.text :verse_2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
