class Bunch < ApplicationRecord

  belongs_to :group
  has_many :cards, dependent: :destroy
  validates :name, presence: true

  def belongs_to?(group)
    self.group_id == group.id
  end

  def as_json(options = {})
    super(options.merge(except: [:group_id, :created_at, :updated_at]))
  end

end
