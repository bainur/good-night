class User < ApplicationRecord
  has_many :sleep_records, dependent: :destroy
  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :follows, source: :followed_user

  def friends_sleep_records
    SleepRecord.joins(user: :follows).where(follows: { followed_user_id: id })
               .where('sleep_records.clock_in_time >= ?', 1.week.ago)
  end

  def check_in(time)
    sleep_record = sleep_records.today.last
    # today check in exist, just update it
    if sleep_record.present?
      sleep_record.update(clock_in_time: time)
    else # create new record for today
      sleep_record = SleepRecord.create(user_id: id, clock_in_time: time)
    end

    sleep_record
  end

  def check_out(time)
    sleep_record = sleep_records.today.last
    # today check in exist, just update it
    sleep_record.update(clock_out_time: time) if sleep_record.present? && sleep_record.clock_out_time.nil?
    sleep_record
  end
end
