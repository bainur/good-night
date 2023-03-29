module Api
  module V1
    class UsersController < BaseController
      before_action :set_follow, only: [:show, :destroy]

      # GET /api/v1/follows
      def index
        @follows = @current_user.follows

        render json: @follows
      end

      # GET /api/v1/follows/1
      def show
        render json: @follow
      end

      # POST /api/v1/follows
      def follow
        @follow = @current_user.follows.build(follow_params)

        if @follow.save
          render json: @follow, status: :created
        else
          render json: @follow.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/follows/1
      def destroy
        @follow.destroy
      end

      private

      def set_follow
        @follow = current_user.follows.find(params[:id])
      end

      def follow_params
        params.require(:follow).permit(:followed_user_id)
      end
    end
  end
end