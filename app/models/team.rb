class Team < ApplicationRecord
  has_many :matches
  has_many :odds, through: :matches
  belongs_to :league
  has_many :team_model_outputs
end
