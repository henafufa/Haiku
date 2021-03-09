class AddBgcolorToHaikus < ActiveRecord::Migration[6.1]
  def change
    add_column :haikus, :bgcolor, :string, default:  ""
    #Ex:- :default =>''
  end
end
