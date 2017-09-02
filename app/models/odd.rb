class Odd < ApplicationRecord
  after_create :set_odds_bias

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

  def default_values
    self.odds_bias_filter ||= false
  end

  def set_odds_bias
     home_prob = match.model_output.home_win_probability
     away_prob = match.model_output.away_win_probability
     draw_prob = match.model_output.draw_probability
     difference = (home_prob - away_prob)
    if difference > 0.3 && outcome == "Home"
      self.odds_bias_filter = true
    elsif difference < -0.3 && outcome == "Away"
      self.odds_bias_filter = true
    elsif difference.abs < 0.15 && outcome == "Draw"
      self.odds_bias_filter = true
    else
      self.odds_bias_filter = false
    end
    save
  end

  def mapped_rating
    highest_valid_score = Odd.where(odds_bias_filter: true).order(rating: :DESC).first.rating
    self.rating = ((self.rating / highest_valid_score) * 100).round(2)
  end

end
