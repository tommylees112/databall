class League < ApplicationRecord
  has_many :matches
  has_many :odds, through: :matches
  ## ADDED
  has_many :teams, through: :matches

  # def teams
  #   matches.
  # end

  def teams
    teams = Team.joins('JOIN matches ON matches.home_team_id = teams.id OR matches.away_team_id = teams.id').joins('JOIN leagues ON matches.league_id = leagues.id').where(league_id: self.id).uniq
    return teams.order_by(:name)
  end
end
