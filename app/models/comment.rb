class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :content, presence: true, length: { maximum:120 }
  default_scope -> { order(created_at: :desc) }
end
