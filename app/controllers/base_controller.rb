class BaseController < ApplicationController
  #before_filter :require_admin!
  before_filter :authenticate_user!
  layout 'layouts/dashboard'
  def index
    @last_signups = User.last_signups(10)
    @last_signins = User.last_signins(10)
    @count = User.users_count
  end
end
