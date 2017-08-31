class OddsController < ApplicationController

  def index
    @odd = Odd.all
  end

  def show
    @odd = Odd.find(params[:id])
    @match = Match.where(status: "TIMED").first
    @bookmaker = @odd.bookmaker
  end
end
