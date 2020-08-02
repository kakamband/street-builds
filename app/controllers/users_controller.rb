class UsersController < ApplicationController
    
    def new 
        @user = User.new 
    end 

    def create 
        
        user = User.create(user_params)

        if user.valid? 
            session[:user_id] = user.id 
            redirect_to cars_path 
        else 
            flash[:error] = user.errors.messages
            redirect_to signup_path 
        end 
    end 

    def show 
        check_user
        locate_user
    end 

    def edit 
        check_user
        locate_user 
    end 

    def update 
        locate_user.update(user_params)
        if @user.valid? 
            redirect_to cars_path
        else
            redirect_to edit_user_path(current_user)
        end 
    end 

    private 
    
    def locate_user 
        @user = User.find(params[:id])
    end 

    def user_params 
        params.require(:user).permit(:first_name, :last_name,  :email, :password, :password_confirmation, :admin, :image_href, :avatar)
    end 
end
