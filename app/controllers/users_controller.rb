class UsersController < ApplicationController
  def connect
    @user = current_user
  end

  def dashboard
    @user = current_user
  end

  def checkme
    ScrappingJob.perform_later(current_user.id)
    redirect_to dashboard_path
  end

  def update
    @user = current_user
    Resource.where(user: @user).destroy_all
    @user.update(user_params)
    redirect_to connect_path
  end

  def linkedin
    @user = current_user
    @resources = @user.resources.where(data_type: "linkedin")

    Resource::DATA_KEY_LINKEDIN.each do |key|
      value = @user.resources.where(data_type: "linkedin").with_key(key).map(&key)
      instance_variable_set("@#{key.to_s.pluralize}", value)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username_linkedin, :username_insta)
  end
end
