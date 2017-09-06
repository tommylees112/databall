class UsersController < ApplicationController
  def dashboard

    @user = current_user

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

    # TOMMY'S CODE
    @bets = @user.bets.order(created_at: :desc)
    @wins = @user.wins
    @losses =@user.losses
    @profit = @bet_returns.reduce(0, :+).round(2)

    # END OF DASHBOARD
  end
  #########
end
