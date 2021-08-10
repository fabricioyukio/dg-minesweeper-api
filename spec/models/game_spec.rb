require 'rails_helper'
require 'spec_helper'

RSpec.describe Game, :type => :model do
  let(:a_player) { Player.create(
    email: 'some_player@example.com',
    username: 'some_player',
    password: 'a_player'
  )}
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

  it "is not valid without valid attributes" do
    a_game = Game.create(
      name: nil, status: 'FAKE_STATUS', 
      lines:1, columns: 50, 
      mines_total: 5200)
    expect(a_game).to_not be_valid
    a_game.name = 'NiceName'
    expect(a_game).to_not be_valid
    a_game.status = 'CREATED'
    expect(a_game).to_not be_valid
    a_game.player = a_player
    a_game.lines = 4
    a_game.columns = 40
    a_game.mines_total = a_game.def_mines_to_deploy
    expect(a_game).to be_valid
  end

  it "is valid with valid attributes" do
    a_game = Game.create(name: nil, player: a_player)
    expect(a_game).to_not be_valid
    a_game.name = 'some handsome name'
    expect(a_game).to be_valid
  end

  it "sets default values when some of them is not given" do
    a_game = Game.create(name: 'test', player: a_player)
    expect(a_game.columns).to eq 4
    expect(a_game.lines).to eq 4
    expect(a_game.status).to eq 'CREATED'
    expect(a_game).to be_valid
  end

  it "properly calculates cells and mines" do
    a_game = Game.create(name: 'test', lines:10, columns:10, player: a_player)
    expect(a_game.cell_count).to eq 100
    expect(a_game.mines_total).to be_between(a_game.min_mines_allowed,a_game.max_mines_allowed)
    expect(a_game).to be_valid
  end

  describe "#deploy" do
    let(:a_game) {
      Game.create(
        name: 'test', lines:10, 
        columns:10, mines_total:25, 
        player: a_player)
    }

    it "deploys the game" do
      expect(a_game.cell_count).to eq 100
      expect(a_game.mines_total).to be_between(
                                    a_game.min_mines_allowed,
                                    a_game.max_mines_allowed
                                  )
      expect(a_game).to be_valid
      a_game.deploy(42)
      expect(a_game.grid[:cells].count).to eq 100
      expect(a_game.grid[:mines_at].count).to eq 25
      expect(a_game.grid[:mines_at].count).to eq 25
      expect(a_game.sessions.length).to eq 1
    end

    it "supports multiple players" do
      a_game.add_player player_1
      expect(a_game.sessions.length).to eq 2
      a_game.add_player player_2
      expect(a_game.sessions.length).to eq 3
    end

    it "blocks a player to be added twice" do
      expect {a_game.add_player(player_1)}.to_not raise_error
      expect(a_game.sessions.length).to eq 2
      expect {a_game.add_player(player_1)}.to_not raise_error
      expect(a_game.sessions.length).to eq 2
      expect {a_game.add_player(player_2)}.to_not raise_error
      expect(a_game.sessions.length).to eq 3
    end
  end
end