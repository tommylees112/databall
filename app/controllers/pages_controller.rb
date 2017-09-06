class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home

    ####### CAN WE ACCESS THIS USERS STUFF ???
    # @model_user = User.find_by first_name: "website_historical"

    # @cumulative_total = []
    #     @model_user.bets.each do |bet|
    #       previous_total = @cumulative_total.last || 0
    #       @cumulative_total << (if bet.won?
    #         previous_total + bet.stake * bet.odd.odds
    #       elsif bet.lost?
    #         previous_total - bet.stake
    #       else
    #         previous_total
    #       end)
    #     end
    #   end

    # @completed_bet_returns = []
    # @completed_bet_status = []
    # @completed_bet_color = []
    # @model_user.completed_bets.each do |bet|
    #   if bet.won?
    #     @completed_bet_returns << bet.stake * bet.odd.odds
    #     @completed_bet_status << "won"
    #     @completed_bet_color << "#50FFB1"
    #   elsif bet.lost?
    #     @completed_bet_returns << - bet.stake
    #     @completed_bet_status << "lost"
    #     @completed_bet_color << "#EA526F"
    #   end
    # end

    # @bet_returns = current_user.completed_bets.map do |bet|
    #   if bet.won?
    #     bet.stake * bet.odd.odds
    #   elsif bet.pending?
    #     0
    #   else
    #     - bet.stake
    #   end
    # end


    # # TOMMY'S CODE
    # @bets = @model_user.bets.order(created_at: :desc)
    # @wins = @model_user.wins
    # @losses = @model_user.losses

    # # CALCULATE TOTAL MONEY BET
    # _stakes = []
    # @bets.each { |bet| _stakes << bet.stake }
    # @total_stake = _stakes.reduce(0, :+)

    # # CACLULATE PROFIT/LOSS
    # _winnings = []
    # @wins.each { |bet| _winnings << ((bet.stake * bet.odd.odds) - bet.stake) }
    # winning_profit = _winnings.reduce(0, :+)
    # _losses = []
    # @losses.each { |bet| _losses << bet.stake}
    # losing_total = _losses.reduce(0, :+)
    # @total_profit = (winning_profit - losing_total).round(2)
  end
end
