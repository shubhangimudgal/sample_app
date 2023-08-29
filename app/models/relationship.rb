class Relationship < ApplicationRecord
    belongs_to :folllower, class_name: "user"
    belongs_to :followed, class_name: "user"
    validates :follower_id, presence: true
    validates :followed_id, presence: true
end
