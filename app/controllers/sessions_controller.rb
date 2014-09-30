class SessionsController < ApplicationController

  def new
  end

  def create
    logger.debug "params = #{params}"
    @user = User.find_by(username: params[:session][:username])
    #@user = User.find_by(email: params[:session][:username]) if @user.nil?
    pwcheck = params[:session][:password]
    if (!@user.nil? && @user.password == pwcheck)
      sign_in @user
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
