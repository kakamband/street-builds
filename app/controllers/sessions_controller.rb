class SessionsController < ApplicationController


    def omniauth 
        binding.pry 
        user = User.create_from_omniauth(auth)
        if user.valid? 
            binding.pry 
            session[:user_id] = user.id 
            redirect_to cars_path
        else 
            redirect_to root_path 
        end 
    end 

    def new 
       @user = User.new 
    end 

    def create 
        if user = User.find_by(email: params[:email])
           if user.authenticate(params[:password])  
                session[:user_id] = user.id 
                redirect_to cars_path 
            else 
                flash[:error] = "Invalid Login or Password"
                redirect_to login_path 
            end 
        else 
            flash[:error] = "Invalid Login or Password"
            redirect_to login_path 
        end 
    end 

    def destroy 
        session.delete :user_id 
        redirect_to root_path 
    end 

    private 

    def login_params 
        
    end 


    def auth 
        request.env['omniauth.auth']
    end 
end
