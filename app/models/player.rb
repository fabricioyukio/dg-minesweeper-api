class Player < ApplicationRecord
  has_many :games
  has_many :sessions
end
