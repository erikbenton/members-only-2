class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by(email: params[:session][:email].downcase)

  	if @user && @user.authenticate(params[:session][:password])
  		login @user
  		flash[:success] = "You have logged in"
  		redirect_to root_url
  	else
  		flash.now[:danger] = "Email and/or password incorrect"
  		render 'new'
  	end

  end

  def destroy
  	if logged_in?
  		log_out
  		flash[:success] = "You have successfully logged out"
  	end
  	redirect_to root_url
  end
end
