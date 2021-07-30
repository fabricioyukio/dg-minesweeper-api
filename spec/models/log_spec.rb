require 'rails_helper'

RSpec.describe Log, type: :model do
  before (:each) do
    @game = Game.create(name: 'test game')
  end
  it "is not valid without valid attributes" do
    a_log = Log.new()
    expect(a_log).to_not be_valid
    a_log.event = "uncover"
    a_log.description = "player uncovered cell"
    expect(a_log).to_not be_valid
  end

  it "is valid with valid attributes" do
    a_log = Log.new(event:'uncover', description: 'player uncovered cell')
    @game.logs << a_log
    expect(a_log).to be_valid
  end
end
