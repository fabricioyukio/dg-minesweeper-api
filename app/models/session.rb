class Session < ApplicationRecord
  belongs_to :player
  belongs_to :game

  validates_uniqueness_of :player, scope: :game
end
