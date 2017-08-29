class BetsController < ApplicationController
  def create
    @bet = Bet.new(bets_params)
  end

  def destroy
    @bet = Bet.find(params[:id])
    @bet.destroy
  end

  def updated
    @bet = Bet.find(params[:id])
    @bet.update(bets_params)
  end

  private

  def bets_params
    params.require(:bet).permit(:stake)
  end

end
