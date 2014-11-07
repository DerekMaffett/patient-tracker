class AngularController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def get_current_user
    render json: current_user, status: 200
  end
end
