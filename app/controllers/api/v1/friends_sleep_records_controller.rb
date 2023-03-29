module Api
  module V1
    class FriendsRecordsController < Api::V1::BaseController
      before_action :set_friend, only: [:show, :update, :destroy]

      # GET /api/v1/friends_records
      def index
        friend_ids = current_user.follows.pluck(:followed_user_id)
        @friends_records = FriendRecord.where(user_id: friend_ids).where(created_at: 1.week.ago..Time.now).order(duration: :desc)

        render json: @friends_records, include: :user
      end

      # GET /api/v1/friends_records/1
      def show
        render json: @friend_record, include: :user
      end

      # POST /api/v1/friends_records
      def create
        @friend_record = FriendRecord.new(friend_record_params)
        @friend_record.user_id = current_user.id

        if @friend_record.save
          render json: @friend_record, status: :created, include: :user
        else
          render json: @friend_record.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/friends_records/1
      def update
        if @friend_record.update(friend_record_params)
          render json: @friend_record, include: :user
        else
          render json: @friend_record.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/friends_records/1
      def destroy
        @friend_record.destroy
      end

      private

      def set_friend
        @friend_record = current_user.friend_records.find(params[:id])
      end

      def friend_record_params
        params.require(:friend_record).permit(:start_time, :end_time)
      end
    end
  end
end
