module Api    
      class BaseController < ApplicationController
        before_action :authenticate_user!

        private

        def authenticate_user!
          unless current_user
            render json: { error: 'Unauthorized' }, status: :unauthorized
          end
        end

        def current_user
          @current_user ||= User.find_by(id: request.headers['X-User-Id'])
        end
    end
  end
  