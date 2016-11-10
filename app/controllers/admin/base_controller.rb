class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :enforce_admin!

  private

  def enforce_admin!
    unless current_user.has_role? :admin
      redirect_to :back, alert: "Access denied."
    end
  end

end
