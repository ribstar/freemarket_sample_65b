# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # def facebook
  #   callback_for(:facebook)
  # end

  # def google_oauth2
  #   callback_for(:google)
  # end
  

  # def callback_for(provider)
  #   @omniauth = request.env['omniauth.auth']
  #   info = User.find_oauth(@omniauth)
  #   @user = info[:user]
  #   if @user.persisted? 
  #     sign_in_and_redirect @user, event: :authentication
  #     set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
  #   else 
  #     @sns = info[:sns]
  #     session[:provider] = @sns[:provider]
  #     session[:uid] = @sns[:uid]
  #     render template: "signup/registration" 
  #   end
  # end

  # def failure
  #   redirect_to root_path and return
  # end
  def facebook
    authorization
  end

  def google_oauth2
    authorization
  end

  def failure
    redirect_to root_path
  end

  private

  def authorization
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted? #ユーザー情報が登録済みなので、新規登録ではなくログイン処理を行う
      sign_in_and_redirect @user, event: :authentication
    else #ユーザー情報が未登録なので、新規登録画面へ遷移する
      render '/signup/index'
    end
  end
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
