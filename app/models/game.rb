class Game < ApplicationRecord
  has_many :logs

  validates_presence_of :name, :status, :columns, :lines
  validates :name, uniqueness: true
  validate :validate_status

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
  end

  def cell_count
    self.lines * self.columns
  end

  def mines_count
    (self.lines * self.columns * 0.2).floor
  end
end
