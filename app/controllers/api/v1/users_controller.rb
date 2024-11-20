module Api
  module V1
    class UsersController < BaseController
      before_action :set_follow, only: [:show, :destroy]

      def index
        @follows = @current_user.follows

        render json: @follows
      end

      def profile
        render json:  UserSerializer.new(@current_user), status: :ok 
      end

      def follow
        @follow = @current_user.follows.build(follow_params)

        if @current_user.follows.find_by_followed_user_id(follow_params[:followed_user_id]).nil? && @follow.save
          render json: @follow, status: :created
        else # this user has follow that user
          render json: { status: :ok, follow: @follow }
        end
      end

      def unfollow
        @follow = @current_user.follows.find_by_followed_user_id(follow_params[:followed_user_id])
        @follow&.destroy
      end

      private

      def set_follow
        @follow = @current_user.follows.find(params[:id])
      end

      def follow_params
        params.require(:follow).permit(:followed_user_id)
      end
    end
  end
end