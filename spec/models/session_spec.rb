require 'rails_helper'

RSpec.describe Session, type: :model do
  let(:player_1) { Player.create(
    email: 'player1@example.com',
    username: 'player1',
    password: 'number 1!'
  )}
  let(:player_2) { Player.create(
    email: 'player2@example.com',
    username: 'player2',
    password: 'number 2!'
  )}
  
  before(:all) do
  end

end
