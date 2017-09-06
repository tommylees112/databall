class BetsController < ApplicationController
  def create
    @bet = Bet.new(bets_params)
    @bet.odd = Odd.find(params[:odd_id])
    @bet.user = current_user
    @bet.save
    @bets = Bet.all
    # redirect_to odds_path
    respond_to do |format|
      format.js
    end
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
