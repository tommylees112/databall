class Team < ApplicationRecord
  has_many :matches
  has_many :odds, through: :matches
  belongs_to :league
  belongs_to :team_model_output
end
