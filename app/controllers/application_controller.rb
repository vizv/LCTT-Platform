class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  private
  
  def current_user
    @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
  end

  def user_signed_in?
    return true if current_user
  end

  def correct_user?
    @user = User.where(id: params[:id]).first
    unless current_user == @user
      flash[:danger] = '访问被拒绝：不匹配的用户，请尝试重新登陆。'
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
    if user_signed_in?
      flash[:danger] = '访问被拒绝：没有足够的权限。'
    else
      flash[:danger] = '访问被拒绝：请先登陆。'
    end
    redirect_to root_path
  end

  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    # TODO: 自定义 404
    render :file => 'public/404.html', :status => :not_found
  end
end
