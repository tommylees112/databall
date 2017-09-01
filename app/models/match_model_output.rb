class MatchModelOutput < ApplicationRecord
  belongs_to :match
  validates :date_updated, uniqueness: {scope: :match_id}
end
