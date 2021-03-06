class Relationship < ApplicationRecord
    include PublicActivity::Model
    tracked owner: ->(controller, model){ controller && controller.current_user}
    belongs_to :follower, class_name: "User"
    belongs_to :followed, class_name: "User"
    has_one :notification, dependent: :destroy
    validates :follower_id, presence: true
    validates :followed_id, presence: true
end
