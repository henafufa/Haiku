class Challenge < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :verse_1, presence: true, length: { maximum: 40 }
  validates :verse_2, length: { maximum: 40 }
end
