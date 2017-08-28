class Team < ApplicationRecord
  has_many :matches
  has_many :odds, through: :matches
end
