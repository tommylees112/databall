class Odd < ApplicationRecord
  VALUES = ["Home", "Away", "Draw"]
  # ASSOCIATIONS
  belongs_to :match
  belongs_to :bookmaker
  has_many :bets
  has_many :users, through: :bets

  # VALIDATIONS
  validates :match, presence: true
  validates :user, presence: true
  validates :odds, presence: true, numericality: true
  validates :outcome, presence: true, inclusion: { in: VALUES }

end
