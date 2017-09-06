class UsersController < ApplicationController
  def dashboard

    @user = current_user

    case params[:b]
    when 'win'
      @user_bets = @user.completed_bets.select { |b| b.won? == 'win' }
    when 'lost'
      @user_bets = @user.completed_bets.select { |b| b.won? == 'lose' }
    when 'pending'
      @user_bets = @user.bets.select { |b| b.won? == 'pending' }
    else
      @user_bets = @user.bets
    end

    @bet_dates = current_user.completed_bets.pluck(:created_at).map{ |d| d.strftime('%d %b %Y') }

    @bet_color = []
    @user.bets.each do |bet|
      if bet.status == "won"
        @bet_color << "#50FFB1"
      elsif bet.status == "lost"
        @bet_color << "#EA526F"
      else
        @bet_color << "#959595"
      end
    end

    @cumulative_total = []
    @user.bets.each do |bet|
      previous_total = @cumulative_total.last || 0
      @cumulative_total << (if bet.won?
        previous_total + bet.stake * bet.odd.odds
      elsif bet.lost?
        previous_total - bet.stake
      else
        previous_total
      end)
    end

    @completed_bet_returns = []
    @completed_bet_status = []
    @completed_bet_color = []
    @user.completed_bets.each do |bet|
      if bet.won?
        @completed_bet_returns << bet.stake * bet.odd.odds
        @completed_bet_status << "won"
        @completed_bet_color << "#50FFB1"
      elsif bet.lost?
        @completed_bet_returns << - bet.stake
        @completed_bet_status << "lost"
        @completed_bet_color << "#EA526F"
      end
    end

    @bet_returns = current_user.completed_bets.map do |bet|
      if bet.won?
        bet.stake * bet.odd.odds
      elsif bet.pending?
        0
      else
        - bet.stake
      end
    end

    @profits = @bet_dates.zip @bet_returns

    ####### TOMMY'S CODE #######
    @bets = @user.bets
    @wins = @user.wins
    @losses = @user.losses

    # CALCULATE TOTAL MONEY BET
    _stakes = []
    @bets.each { |bet| _stakes << bet.stake }
    @total_stake = _stakes.reduce(0, :+)

    # CACLULATE PROFIT/LOSS
    _winnings = []
    @wins.each { |bet| _winnings << ((bet.stake * bet.odd.odds) - bet.stake) }
    winning_profit = _winnings.reduce(0, :+)
    _losses = []
    @losses.each { |bet| _losses << bet.stake}
    losing_total = _losses.reduce(0, :+)
    @total_profit = (winning_profit - losing_total).round(2)

    # END OF DASHBOARD
  end
  #########
end
