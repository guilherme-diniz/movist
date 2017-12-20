
class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @profile_image = "http://graph.facebook.com/#{current_user.uid}/picture?type=large"
  end
end