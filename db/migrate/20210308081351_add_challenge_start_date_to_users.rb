class AddChallengeStartDateToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :challenge_start_date, :datetime, default: false
  end
end
