class Reaction < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model){ controller && controller.current_user}
  belongs_to :user
  belongs_to :micropost
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :user_id, uniqueness: { scope: :micropost_id }
  
end
