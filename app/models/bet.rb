class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :odd
  has_one :match, through: :odd
  has_one :home_team, through: :match
  has_one :away_team, through: :match

  # VALIDATIONS
  validates :user_id, uniqueness: { scope: :odd_id }
end
