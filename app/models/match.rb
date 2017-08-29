class Match < ApplicationRecord
  # ASSOCIATIONS

  belongs_to :home_team, :class_name => :Team, :foreign_key => "home_team_id"
  belongs_to :away_team, :class_name => :Team, :foreign_key => "away_team_id"
  belongs_to :league
  has_many :odds
  has_many :bets, through: :odds
  has_many :users, through: :bets ##HOW TO WRITE THIS?
  # eg has_many :owned_odds, through: :bookings, source: :odds

  # VALIDATIONS

  validates :match_date, presence: true
  validates :gameweek, presence: true, numericality: true
  validates :league, presence: true
end
