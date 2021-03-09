class DailyChallenge < ApplicationRecord
  # include PublicActivity::Model
  # tracked
  belongs_to :user
  validates :user_id, presence: true
  # validates :postStatus, presence: true
  validates :thirtyDates, presence: true
end
