class UsersController < ApplicationController
  def dashboard
    @user = current_user

  case params[:b]
   when 'win'
      @user_bookings = @user.bets.joins(:odd).joins(:match).joins(:bet).where(won: true).order('matches.match_date DESC')
    when 'lost'
      @user_bookings = @user.bets.joins(:odd).joins(:match).joins(:bet).where(won: false).order('matches.match_date DESC')
    when 'pending'
      @user_bookings = @user.bets.joins(:odd).joins(:match).joins(:bet).where(won: nil).order('matches.match_date DESC')
    when 'all'
      @user_bookings = @user.bets.joins(:odd).joins(:match).joins(:bet).order('matches.match_date DESC')
    else
      @user_bookings = @user.bets.joins(:odd).joins(:match).joins(:bet).order('matches.match_date DESC')
    end

  end

end
