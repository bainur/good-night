class User < ApplicationRecord
  has_many :sleep_records, dependent: :destroy
  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :follows, source: :followed_user

  def friends_sleep_records
    SleepRecord.joins(user: :follows)
               .where(follows: { follower_id: id })
               .where("sleep_records.clock_in_time >= ?", 1.week.ago)
               .order("(sleep_records.clock_out_time - sleep_records.clock_in_time) DESC")
  end

  def latest_sleep
   self.sleep_records.order('id desc').first
  end
end
