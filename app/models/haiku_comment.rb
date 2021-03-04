class HaikuComment < ApplicationRecord
  belongs_to :user
  belongs_to :haiku
  default_scope -> { order(created_at: :desc) }

  validates :verse_1, presence: true, length: { maximum: 40 }
  validates :verse_2, presence: true, length: { maximum: 40 }
  validates :verse_3, presence: true, length: { maximum: 40 }
end
