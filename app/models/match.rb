class Match < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :home_team
  belongs_to :away_team
  belongs_to :league
  has_many :odds
  has_many :bets, through: :odds
  has_many :users, through: :bets ##HOW TO WRITE THIS?

  # VALIDATIONS
  validates :home_team, presence: true
  validates :away_team, presence: true
  validates :match_date, presence: true
  validates :gameweek, presence: true, numericality: true
  validates :league, presence: true
end
