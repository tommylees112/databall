class League < ApplicationRecord
  has_many :matches
  has_many :odds, through: :matches
  has_many :teams
end
