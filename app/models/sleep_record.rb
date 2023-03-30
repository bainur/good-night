# frozen_string_literal: true
class SleepRecord < ApplicationRecord
  belongs_to :user

  scope :ordered_by_created_time, -> { order(created_at: :asc) }
  scope :today, -> { where('date(created_at) = ?', Date.today )}
end
