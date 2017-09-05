class Bet < ApplicationRecord
  enum status: [ :pending, :won, :lost ]

  belongs_to :user
  belongs_to :odd
  has_one :match, through: :odd

  after_save :update_status

  # VALIDATIONS
  # validates :user_id, uniqueness: { scope: :odd_id }

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

  def update_status
    return if self.match.status != 'FINISHED'
      if self.match.goals_home_team > self.match.goals_away_team
        self.odd.outcome == 'Home' ? self.won! : self.lost!
      elsif goals_home_team < goals_away_team
        self.odd.outcome == 'Away' ? self.won! : self.lost!
      else
        self.odd.outcome == 'Draw' ? self.won! : self.lost!
      end
  end
end
