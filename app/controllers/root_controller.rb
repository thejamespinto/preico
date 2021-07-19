class RootController < ApplicationController
  def index
    if current_user
      redirect_to home_path
    else
      redirect_to auth_path
    end
  end
end
