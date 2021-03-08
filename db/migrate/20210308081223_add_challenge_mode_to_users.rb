class AddChallengeModeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :challenge_mode, :boolean, default: false
  end
end
