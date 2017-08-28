class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :odd
  has_one :match, through: :odd

  # VALIDATIONS
  validates :user_id, uniqueness: { scope: :odd_id }
end
