class AddTagToHaikus < ActiveRecord::Migration[6.1]
  def change
    add_column :haikus, :tag, :string
  end
end
