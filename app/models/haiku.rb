class Haiku < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :verse_1, presence: true, length: { maximum: 40 }
  validates :verse_2, presence: true, length: { maximum: 40 }
  validates :verse_3, presence: true, length: { maximum: 40 }

  has_many :haiku_comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }

end
