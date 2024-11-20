class SleepRecord < ApplicationRecord
  belongs_to :user
  
  scope :ordered_by_created_time, -> { order(created_at: :asc) }
end
