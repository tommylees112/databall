class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :odd
  has_one :match, through: :odd
  after_initialize :init

  def init
    self.won  ||= nil
  end

  # VALIDATIONS
  validates :user_id, uniqueness: { scope: :odd_id }
end
