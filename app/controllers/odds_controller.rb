class OddsController < ApplicationController

  def index
    @odds = Odd.all
  end

  def show
    @odd = Odd.find(params[:id])
  end

end
