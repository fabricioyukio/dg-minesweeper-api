class Log < ApplicationRecord
  belongs_to :game

  validates :event, :description, presence: true
end
