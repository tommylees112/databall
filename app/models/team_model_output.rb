class TeamModelOutput < ApplicationRecord
  belongs_to :team
  validates :last_updated, uniqueness: true
end
