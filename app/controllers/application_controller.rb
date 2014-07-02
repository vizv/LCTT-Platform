class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  private
  
  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue Exception => e
      nil
    end
  end

  def user_signed_in?
    return true if current_user
  end

  def correct_user?
    @user = User.find(params[:id])
    unless current_user == @user
      flash[:danger] = '访问被拒绝。'
      redirect_to root_url
    end
  end

  def authenticate_user!
    if !current_user
      flash[:danger] = '你需要登陆后才能访问该页面。'
      redirect_to root_url
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = '访问被拒绝。'
    redirect_to root_path
  end
end
