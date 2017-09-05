class Bet < ApplicationRecord
  enum status: [ :pending, :won, :lost ]

  belongs_to :user
  belongs_to :odd
  has_one :match, through: :odd

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
end
