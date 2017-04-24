class RoutesController < ApplicationController
  def index
    @routes = Route.all.sort_by do |route|
      route.route_short_name.to_i
    end
  end

  def show
    @route = Route.find(params[:id])
  end
end
