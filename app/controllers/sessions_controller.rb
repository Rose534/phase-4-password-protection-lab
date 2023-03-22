class SessionsController < ApplicationController
    
    def create
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          render json: @user
        else
            return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
        end
      end
    
      def destroy
       
        session[:user_id] = nil
        head :no_content
      end
    
end
