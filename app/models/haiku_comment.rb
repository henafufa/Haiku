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

class HaikuComment < ApplicationRecord
  # include PublicActivity::Model
  # tracked
  belongs_to :user
  belongs_to :haiku
  default_scope -> { order(created_at: :desc) }

  validates :verse_1, presence: true, length: { maximum: 40 }
  validates :verse_2, presence: true, length: { maximum: 40 }
  validates :verse_3, presence: true, length: { maximum: 40 }

  validates_with HaikuValidator

end
