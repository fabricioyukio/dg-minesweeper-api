class Game < ApplicationRecord
  belongs_to :player

  has_many :logs
  has_many :sessions
  has_many :players, :through => :sessions

  validates_presence_of :name, :status, :columns, :lines
  validates :name, uniqueness: true
  validate :validate_status
  validate :validate_mines_count
  validates :lines, :columns, :mines_total, numericality: {only_integer: true}
  validates :lines, numericality: {
                                    greater_than_or_equal_to: 4, 
                                    less_than_or_equal_to: 80
                                  }
  validates :columns, numericality: {
                                    greater_than_or_equal_to: 4, 
                                    less_than_or_equal_to: 80
                                  }

  scope :playable, -> { where(:status => ['CREATED','OPEN']) }
  scope :ended, -> { where(:status => ['FINISHED','OVER']) }

  attr_accessor :grid

  # CALLBACKS
  after_create :add_player

  # Deploys mines in the GRID
  def deploy(initial_cell=0)
    unless valid?
      raise StandardError.new "Can't deploy mines on a invalid game."
    end

    cells = (1..cell_count).to_a
    
    # begin <code> end while <condition> is reject by Matz-san
    # he suggests to use loop instead
    mined_positions = []
    loop do
      mined_positions = (cells.sample(mines_total).to_a).sort!
      break if !(mined_positions.include? initial_cell)
    end

    elements = []
    cells.each do|n|
      elements << {
        revealed: false,
        mined: mined_positions.include?(n),
        mines_near: 0,
        number: n,
        marked: false
      }
    end

    @grid = {
      cells: elements,
      mines_at: mined_positions,
      sweeps: []
    }
  end

  def validate_status
    unless %w[CREATED OPEN FINISHED OVER].include? self.status
      errors.add(:status, 'Not a valid status')
    end
  end

  def validate_mines_count
    unless min_mines_allowed <= mines_total and mines_total <= max_mines_allowed
      errors.add(:mines_total, 
        "Not a valid quantity of mines, must a value between "\
        "#{min_mines_allowed} and #{max_mines_allowed}, "\
        "you have #{mines_total}"
      )
    end
  end

  def cell_count
    self.lines * self.columns
  end

  # Minimum mines to be set for having a game
  def min_mines_allowed
    1
  end

  # Maximum mines to be set for a playable game
  def max_mines_allowed
    (self.lines * self.columns * 0.4).floor
  end

  # Default mines to be set for a balanced game
  def def_mines_to_deploy
    (self.lines * self.columns * 0.2).floor
  end

  def add_player (player = self.player)
    unless players.include?(player)
      sessions << Session.create(
        game_id: self.id,
        player_id: player.id
      )
    end
  end
end
