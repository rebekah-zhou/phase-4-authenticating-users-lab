class SessionController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_msg
    def create 
        user = User.find_by(username: params[:username])
        session[:user_id] ||= user.id
        render json: user
    end

    def destroy
        session.delete :user_id
        head :no_content
    end

    private 
    def render_not_found_msg
        render json: { error: "User not found" }, status: :not_found
    end
end
