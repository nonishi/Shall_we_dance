class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    users_sign_up_complete_path(resource)
  end

end
