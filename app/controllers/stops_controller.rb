class StopsController < ApplicationController
  before_action :set_stop, only: [:show]
  def index
    @stops = Stop.all
  end

  def show
  end

  private

  def set_stop
    @stop = Stop.find(params[:id])
  end
end
