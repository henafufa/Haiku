class CreateHaikuComments < ActiveRecord::Migration[6.1]
  def change
    create_table :haiku_comments do |t|
      t.text :verse_1
      t.text :verse_2
      t.text :verse_3
      t.references :user, null: false, foreign_key: true
      t.references :haiku, null: false, foreign_key: true

      t.timestamps
    end
  end
end
