# app/controllers/api/v1/sleep_records_controller.rb
module Api
  module V1
    # Sleep Records controller
    class SleepRecordsController < BaseController
      def clock_in
        sleep_record = @current_user.check_in(Time.current)

        render json: { status: :ok, message: 'Clock in Success', sleep_record: sleep_record
          .as_json(except: %i[created_at updated_at]) }
      end

      def clock_out
        sleep_record = @current_user.check_out(Time.current)

        render json: { status: :ok, message: 'Clock out Success', sleep_record: sleep_record
          .as_json(except: %i[created_at updated_at]) }
      end

      def index
        sleep_records = @current_user.sleep_records.order(created_at: :desc)

        render json: { status: :ok, sleep_records: sleep_records.as_json(except: %i[created_at updated_at]) }
      end

      def friends_sleep_records
        sleep_records = @current_user.friends_sleep_records
        render json: { status: :ok, sleep_records: sleep_records.as_json(except: %i[created_at updated_at]) }
      end
    end
  end
end
