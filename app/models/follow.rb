class Follow < ApplicationRecord
  belongs_to :follower
  belongs_to :followed_user
end
