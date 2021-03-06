class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def twitter
    current_user.update(
      twitter_oauth_data: request.env['omniauth.auth'].credentials,
      username_twitter: request.env['omniauth.auth'].extra.access_token.params[:screen_name]
    )
    set_flash_message(:notice, :success, :kind => "twitter") if is_navigational_format?
    redirect_to connect_path
  end
end
