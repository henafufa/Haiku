class ChallengeUser < ApplicationRecord
  belongs_to :challenge
  belongs_to :user
  validates :user_id, presence: true
  validates :challenge_id, presence: true
end
