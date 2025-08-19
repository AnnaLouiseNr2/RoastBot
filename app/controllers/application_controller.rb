class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    resource.create_default_people
    people_path
  end
end
