class UsersController < ApplicationController
  def dashboard
    redirect_to new_charge_path if current_user.access == false
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
    @user.bets.each do |b|
      if b.won? == "win"
        @bet_color << "#50FFB1"
      else
        @bet_color << "#EA526F"
      end
    end

    @bet_returns = current_user.completed_bets.map do |b|
      case b.won?
      when 'win'
        b.stake * b.odd.odds
      when 'pending'
        0
      when 'lose'
        - b.stake
      end
    end
  end

end
