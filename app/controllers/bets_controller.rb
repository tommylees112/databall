class BetsController < ApplicationController
  def create
    @bet = Bet.new(bets_params)
    @bet.odd = Odd.find(params[:odd_id])
    @bet.user = current_user
    @bet.save
    redirect_to odds_path
  end

  def destroy
    @bet = Bet.find(params[:id])
    @bet.destroy
  end

  def updated
    @bet = Bet.find(params[:id])
    @bet.update(bets_params)
  end

  def index
    @bets = Bet.all
  end

  def show
    @bets = current_user.bets
    @bet = Bet.find(params[:id])
  end

  private

  def bets_params
    params.require(:bet).permit(:stake)
  end

end
