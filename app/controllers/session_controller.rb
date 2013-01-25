class SessionController < ApplicationController
  def new
  end

  def create
    raise
    user = params[:user]
    respond_to do |format|
      if @user = login(user[:username], user[:password], user[:remember])
        format.html { redirect_back_or_to(root_path, :notice => I18n::t('Login successfull.')) }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { flash.now[:alert] = I18n::t("Login failed."); render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    logout
    redirect_to( root_url, :notice => I18n::t('Logged out') )
  end
end
