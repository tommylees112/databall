class OddsController < ApplicationController

  def index
    @odds = Odd.all
    @bet = Bet.new
  end

  def show
    @odd = Odd.find(params[:id])
    @bet = Bet.new
    @match = @odd.match #Match.where(status: "TIMED").first
    @bookmaker = @odd.bookmaker
  end

end
