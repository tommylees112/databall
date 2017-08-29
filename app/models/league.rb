class League < ApplicationRecord
  has_many :matches
  has_many :odds, through: :matches

  def teams
    teams = Team.joins('JOIN matches ON matches.home_team_id = teams.id OR matches.away_team_id = teams.id')
    teams = teams.joins('JOIN leagues ON matches.league_id = leagues.id')
    teams = teams.where(league_id: self.id).uniq
    return teams.order(:name)
  end

end
