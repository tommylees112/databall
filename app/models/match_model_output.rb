class MatchModelOutput < ApplicationRecord
  belongs_to :match
  validates :last_updated, uniqueness: true
end
