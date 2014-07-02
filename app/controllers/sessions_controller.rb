class SessionsController < ApplicationController
  def new
    redirect_to '/auth/github'
  end

  def create
    auth = request.env["omniauth.auth"]

    user = User.where(:uid => auth['uid'].to_s).first
    user ||= User.create! uid: auth['uid'], name: auth['info']['nickname']

    reset_session
    session[:user_id] = user.id
    user.add_role :admin if User.count == 1 # make the first user an admin
    flash[:success] = '成功登陆!'
    redirect_to root_path
  end

  def destroy
    reset_session
    flash[:success] = '成功登出!'
    redirect_to root_path
  end

  def failure
    flash[:error] = '与 Github 通讯时发生错误!'
    redirect_to root_path
  end
end
