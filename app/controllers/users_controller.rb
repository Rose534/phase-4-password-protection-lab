class UsersController < ApplicationController

    
    def create
        user = User.create(user_params)
        if user.valid?
          session[:user_id] = user.id # Save the user id in the session
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
    
      def show
        if current_user 
          render json: current_user 
        else
          render json: { errors: ['Unauthorized'] }, status: :unauthorized
        end
      end
    
      private
    
      def user_params
        params.permit(:username, :password, :password_confirmation)
      end
    
      def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      end

end
