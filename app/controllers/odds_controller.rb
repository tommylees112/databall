class OddsController < ApplicationController

  def index
    if params[:league].present?
      query = <<-SQL
        SELECT *
        FROM odds o1
        JOIN matches ON o1.match_id = matches.id
        JOIN leagues ON matches.league_id = leagues.id
        WHERE leagues.name = :league_name
        AND o1.id IN (
          SELECT id
            FROM odds o2
            WHERE o2.match_id = o1.match_id
            AND o2.odds_bias_filter = true
          ORDER BY o2.rating DESC
          LIMIT 1
        )
        ORDER BY o1.rating DESC
      SQL
      @odds = Odd.find_by_sql [ query, league_name: params[:league] ]
    else
      # Recommended:
      @odds = Odd.find_by_sql <<-SQL
        SELECT *
        FROM odds o1
        WHERE o1.id IN (
          SELECT id
            FROM odds o2
            WHERE o2.match_id = o1.match_id
            AND o2.odds_bias_filter = true
          ORDER BY o2.rating DESC
          LIMIT 1
        )
        ORDER BY o1.rating DESC
        LIMIT 5
      SQL
    end

    @bet = Bet.new
  end

  def show
    redirect_to new_charge_path if current_user.access == false
    @odd = Odd.find(params[:id])
    @bet = Bet.new
    @match = @odd.match #Match.where(status: "TIMED").first
    @bookmaker = @odd.bookmaker
  end

end
