class Match < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'
  belongs_to :away_team, class_name: 'Team', foreign_key: 'away_team_id'

  belongs_to :league
  has_many :odds
  has_many :bets, through: :odds
  has_many :users, through: :bets

  # VALIDATIONS

  validates :match_date, presence: true
  validates :gameweek, presence: true, numericality: true
  validates :league, presence: true

  def teams
    { home: home_team, away: away_team }
  end

  def flat_teams
    [ home_team, away_team ]
  end
end
