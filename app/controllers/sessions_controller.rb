class SessionsController < ApplicationController
  def new
    redirect_to '/auth/github'
  end

  def create
    auth = request.env["omniauth.auth"]

    user = User.where(:provider => auth['provider'], :uid => auth['uid'].to_s).first
    user ||= User.create! uid: auth['uid'], name: auth['info']['nickname']

    reset_session
    session[:user_id] = user.id
    user.add_role :admin if User.count == 1 # make the first user an admin
    redirect_to root_url, :notice => '成功登陆!'
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => '成功登出!'
  end

  def failure
    redirect_to root_url, :alert => "与 Github 通讯时发生错误： #{params[:message].humanize}"
  end
end
