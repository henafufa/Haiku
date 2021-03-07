class Haiku < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :user_id, presence: true
  validates :verse_1, presence: true, length: { maximum: 40 }
  validates :verse_2, presence: true, length: { maximum: 40 }
  validates :verse_3, presence: true, length: { maximum: 40 }
  has_many :haiku_comments, dependent: :destroy
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" }, size: { less_than: 5.megabytes, message: "should be less than 5MB" }

  default_scope -> { order(created_at: :desc) }

  def display_image
    p 'active ///////////////////'
    image.variant(resize_to_limit: [500, 500])
 
  end
end
