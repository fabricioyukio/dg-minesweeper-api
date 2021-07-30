class Game < ApplicationRecord
  has_many :logs

  validates_presence_of :name, :status, :columns, :lines
  validates :name, uniqueness: true
  validate :validate_status
  validates :lines, :columns, numericality: {only_integer: true}
  validates :lines, numericality: {
                                    greater_than_or_equal_to: 4, 
                                    less_than_or_equal_to: 80
                                  }
  validates :columns, numericality: {
                                    greater_than_or_equal_to: 2, 
                                    less_than_or_equal_to: 40
                                  }

  after_initialize :default_values
  before_save :default_values

  scope :playable, -> { where(:status => ['CREATED','OPEN']) }
  scope :ended, -> { where(:status => ['FINISHED','OVER']) }

  def deploy_mines
    (1..cell_count).to_a.sample(mines_count)
  end

  def validate_status
    unless %w[CREATED OPEN FINISHED OVER].include? self.status
      errors.add(:status, 'Not a valid status')
    end
  end

  def default_values
    self.status   ||= 'CREATED'
    self.lines    ||= 16
    self.columns  ||= 30
    self.mines_total = mines_count
  end

  def cell_count
    self.lines * self.columns
  end

  def mines_count
    (self.lines * self.columns * 0.2).floor
  end
end
