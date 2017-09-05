class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :odd
  has_one :match, through: :odd
  after_initialize :init

  def init
    self.won ||= nil
  end

  # VALIDATIONS
  # validates :user_id, uniqueness: { scope: :odd_id }

  # METHODS
  def won?
    if (self.match.status == 'FINISHED')
      # FIND THE MATCH RESULT
      outcome_true = ""
      if self.match.goals_home_team > self.match.goals_away_team
        outcome_true = "Home"
      elsif self.match.goals_home_team < self.match.goals_away_team
        outcome_true = "Away"
      elsif self.match.goals_home_team == self.match.goals_away_team
        outcome_true = "Draw"
      end
      # COMPARE TO THE BET PREDICTION
      if (self.odd.outcome == outcome_true)
        bet_outcome = "win"
        self.update(won: true)
      else
        bet_outcome = "lose"
        self.update(won: false)
      end
    # FOR UNFINISHED BETS
    else
      bet_outcome = "pending"
    end
    return bet_outcome
  end

  def winnings
    if won?
      return (stake * odd.odds).round(2)
    else
      return - (stake).round(2)
    end
  end

  def potential_winnings
    return (stake * odd.odds).round(2)
  end
end
