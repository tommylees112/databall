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
      if bet.won? == "win"
        @bet_color << "#50FFB1"
      else
        @bet_color << "#EA526F"
      end
    end

    @cumulative_total =


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
    @bets = @user.bets
    @wins = @user.wins
    @losses =@user.losses
    @profit = @bet_returns

    # END OF DASHBOARD
  end
  #########
end
