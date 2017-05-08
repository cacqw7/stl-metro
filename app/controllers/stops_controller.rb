class StopsController < ApplicationController

  def index
    @stops = Stop.pluck(:id, :stop_name)
  end

  def show
    @stop = Stop.find(params[:id])
  end

end
