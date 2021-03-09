class DailyChallenge < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model){ controller && controller.current_user}
  belongs_to :user
  validates :user_id, presence: true
  # validates :postStatus, presence: true
  validates :thirtyDates, presence: true
end
