class CreateHaikus < ActiveRecord::Migration[6.1]
  def change
    create_table :haikus do |t|
      t.text :verse_1
      t.text :verse_2
      t.text :verse_3
      t.boolean :public, default: true
      t.string :bgcolor, default: ""
      #Ex:- :default =>''
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :haikus, [:user_id, :created_at]
  end
end

