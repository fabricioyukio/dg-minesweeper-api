require 'rails_helper'
require 'spec_helper'

RSpec.describe Game, :type => :model do
  it "is not valid without valid attributes" do
    a_game = Game.new(name: nil, status: 'FAKE_STATUS')
    expect(a_game).to_not be_valid
    a_game.name = 'NiceName'
    expect(a_game).to_not be_valid
    a_game.status = 'CREATED'
    expect(a_game).to be_valid
  end

  it "is valid with valid attributes" do
    a_game = Game.new(name: nil)
    expect(a_game).to_not be_valid
    a_game.name = 'some handsome name'
    expect(a_game).to be_valid
  end

  it "set default values" do
    a_game = Game.new(name: 'test')

    expect(a_game.columns).to eq 20
    expect(a_game.lines).to eq 16
    expect(a_game.status).to eq 'CREATED'
  end

  it "properly calculates cells" do
    a_game = Game.new(name: 'test', lines:10, columns:10)
    expect(a_game.cell_count).to eq 100
    expect(a_game.mines_count).to eq 20
    expect(a_game.deploy_mines.length).to eq 20
  end
end