class ChallengeUser < ApplicationRecord
  belongs_to :challenge
  belongs_to :user
  has_one :notification, dependent: :destroy
  validates :user_id, presence: true
  validates :challenge_id, presence: true
end
