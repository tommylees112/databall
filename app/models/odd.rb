class Odd < ApplicationRecord
  VALUES = ["Home", "Away", "Draw"]
  # ASSOCIATIONS
  belongs_to :match
  belongs_to :bookmaker
  has_many :bets
  has_many :users, through: :bets ## HOW TO WRITE THIS??

  # VALIDATIONS
  validates :match, presence: true
  validates :odds, presence: true
  validates :outcome, presence: true, inclusion: { in: VALUES }

  def self.rank
  end
end
