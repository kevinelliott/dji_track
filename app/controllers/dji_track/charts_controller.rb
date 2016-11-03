class DjiTrack::ChartsController < ApplicationController
  def orders_by_country
    render json: Order.group_by_day(:completed_at).count
  end
end