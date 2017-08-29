class OddsController < ApplicationController

  def index
    @odd = Odd.all
  end

  def show
    @odd = Odd.find(params[:id])
  end
end
