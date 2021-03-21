class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :haiku_reaction, optional: true
  belongs_to :haiku_comment, optional: true
  belongs_to :challenge_user, optional: true
  belongs_to :relationship, optional: true
end
