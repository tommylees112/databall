class OddsController < ApplicationController

  def index
    @odd = Odd.all
  end

  def show
    @odd = Odd.find(params[:id])
    @match = @odd.match #Match.where(status: "TIMED").first
    @bookmaker = @odd.bookmaker
  end
end
