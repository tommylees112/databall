class OddsController < ApplicationController

  def index
    @odds = Odd.where(odds_bias_filter: true).order(rating: :DESC)
    @bet = Bet.new
  end

  def show
    @odd = Odd.find(params[:id])
    @bet = Bet.new
    @match = @odd.match #Match.where(status: "TIMED").first
    @bookmaker = @odd.bookmaker
  end

end
