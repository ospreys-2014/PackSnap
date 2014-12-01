class SessionController < ApplicationController
  def new
    render :login
  end

  def login
    @user = User.find_by(email: user_params[:email]).try(:authenticate, user_params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to root_path
    else
      set_error(@user)
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirm)
  end
end