class HaikuValidator < ActiveModel::Validator
  include HaikusHelper

  def validate(record)
    if record.verse_1 && !verse_1_haiku?(record.verse_1)
      record.errors.add :base, "First verse should be exactly 5 syllabes but found #{SyllableCount(record.verse_1)}"
    end
    if record.verse_2 && !verse_2_haiku?(record.verse_2)
      record.errors.add :base, "Second verse should be exactly 7 syllabes but found #{SyllableCount(record.verse_2)}"
    end
    if record.verse_3 && !verse_3_haiku?(record.verse_3)
      record.errors.add :base, "Third verse should be exactly 5 syllabes but found #{SyllableCount(record.verse_3)}"
    end
  end
end
class Haiku < ApplicationRecord
  
  belongs_to :user
  has_one_attached :image
  validates :user_id, presence: true
  validates :verse_1, presence: true, length: { maximum: 40 }
  validates :verse_2, presence: true, length: { maximum: 40 }
  validates :verse_3, presence: true, length: { maximum: 40 }
  validates :tag, length: { maximum: 15 }
  has_many :haiku_comments, dependent: :destroy
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" }, size: { less_than: 5.megabytes, message: "should be less than 5MB" }

  validates_with HaikuValidator

  default_scope -> { order(created_at: :desc) }

  def display_image
    image.variant(resize_to_limit: [500, 500])
 
  end
end


