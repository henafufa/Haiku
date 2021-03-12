class HaikuReaction < ApplicationRecord
  belongs_to :user
  belongs_to :haiku

  validates :user_id, presence: true
  validates :haiku_id, presence: true
  validates :user_id, uniqueness: { scope: :haiku_id }
end
