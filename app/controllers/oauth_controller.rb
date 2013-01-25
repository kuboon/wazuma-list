class OauthController < ApplicationController
  skip_before_filter :require_login

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def index(provider)
    login_at(provider)
  end

  def callback(provider)
    @user = login_from(provider)

    if @user
      @user.authentication(provider).update_attributes(access_token: access_token(provider), user_info_hash: @user_hash)
      return redirect_back_or_to root_url
    end

    @user = create_from(provider)
    @user.authentication(provider).update_attributes(access_token: access_token(provider), user_info_hash: @user_hash)

    # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule

    reset_session # protect from session fixation attack
    auto_login(@user)
    @user.join_to_list
    redirect_back_or_to root_url
  end
end