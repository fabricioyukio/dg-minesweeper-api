require 'rails_helper'
require 'spec_helper'

RSpec.describe Game, :type => :model do
  it "is not valid without valid attributes" do
    a_game = Game.create(name: nil, status: 'FAKE_STATUS', lines:1, columns: 50, mines_total: 5200)
    expect(a_game).to_not be_valid
    a_game.name = 'NiceName'
    expect(a_game).to_not be_valid
    a_game.status = 'CREATED'
    expect(a_game).to_not be_valid
    a_game.lines = 4
    a_game.columns = 40
    a_game.mines_total = a_game.def_mines_to_deploy
    expect(a_game).to be_valid
  end

  it "is valid with valid attributes" do
    a_game = Game.create(name: nil)
    expect(a_game).to_not be_valid
    a_game.name = 'some handsome name'
    expect(a_game).to be_valid
  end

  it "sets default values when some of them is not given" do
    a_game = Game.create(name: 'test')
    expect(a_game.columns).to eq 4
    expect(a_game.lines).to eq 4
    expect(a_game.status).to eq 'CREATED'
    expect(a_game).to be_valid
  end

  it "properly calculates cells and mines" do
    a_game = Game.create(name: 'test', lines:10, columns:10)
    expect(a_game.cell_count).to eq 100
    expect(a_game.mines_total).to be_between(a_game.min_mines_allowed,a_game.max_mines_allowed)
    expect(a_game).to be_valid
  end

  describe "#deploy" do
    it "deploys the game" do
      a_game = Game.create(name: 'test', lines:10, columns:10, mines_total:25)
      expect(a_game.cell_count).to eq 100
      expect(a_game.mines_total).to be_between(a_game.min_mines_allowed,a_game.max_mines_allowed)
      expect(a_game).to be_valid
      a_game.deploy(42)
      expect(a_game.grid[:cells].count).to eq 100
      expect(a_game.grid[:mines_at].count).to eq 25
      expect(a_game.grid[:mines_at].count).to eq 25
    end
  end
end