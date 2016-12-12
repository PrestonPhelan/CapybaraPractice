class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login(@user)
      #redirect
    else
      flash.now[:errors] = ["invalid login!2"]
      render :new
    end
  end

  def destroy
    logout
  end


end
