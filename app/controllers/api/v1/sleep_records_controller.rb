# app/controllers/api/v1/sleep_records_controller.rb
module Api
  module V1
    class SleepRecordsController < BaseController

      def clock_in
        sleep_record = @current_user.sleep_records.create(clock_in_time: Time.current)

        render json: { sleep_record: sleep_record }
      end

      def clock_out
        sleep_record = current_user.latest_sleep.update(clock_out_time: Time.current)

        render json: { sleep_record: sleep_record }
      end

      def index
        sleep_records = current_user.sleep_records.order(created_at: :desc)

        render json: { sleep_records: sleep_records }
      end

      def friends_sleep_records
        friends = current_user.following.pluck(:id)

        sleep_records = SleepRecord.where(user_id: friends).where(created_at: 1.week.ago..Time.current)
                                   .select('*, (clock_out - clock_in) as sleep_duration')
                                   .order('sleep_duration desc')

        render json: { sleep_records: sleep_records }
      end
    end
  end
end
