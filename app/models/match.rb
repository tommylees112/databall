class Match < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'
  belongs_to :away_team, class_name: 'Team', foreign_key: 'away_team_id'

  belongs_to :league
  has_many :odds
  has_many :bets, through: :odds
  has_many :users, through: :bets
  has_many :match_model_outputs

  # VALIDATIONS
  VALUES = ["Home", "Away", "Draw"]
  validates :match_date, presence: true
  validates :gameweek, presence: true, numericality: true
  validates :league, presence: true
  # validates :outcome, inclusion: {in: VALUES}

  def teams
    { home: home_team, away: away_team }
  end

  def flat_teams
    [ home_team, away_team ]
  end

  def outcome
    if self.status = "FINISHED"
      outcome = ""
      if self.goals_home_team > self.goals_away_team
        outcome = "Home"
       elsif self.goals_home_team < self.goals_away_team
         outcome = "Away"
       elsif self.goals_home_team == self.goals_away_team
         outcome = "Draw"
       end
    end
  end

  def model_output
    self.match_model_outputs.order(created_at: :desc).first
  end

  def model_outcome_probability(odd)
    if odd.outcome == "Home"
      return self.model_output.home_win_probability
    elsif odd.outcome == "Away"
      return self.model_output.away_win_probability
    elsif odd.outcome == "Draw"
      return self.model_output.draw_probability
    else
      return "N/A"
    end
  end

  def model_outcome_odds(odd)
    probability = self.model_outcome_probability(odd)
    model_odds = 1/probability
    return model_odds.round(2)
  end

end
