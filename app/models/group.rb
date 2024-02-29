class Group < ApplicationRecord

  belongs_to :user
  has_many :cards, dependent: :destroy

  validates :name, presence: true

  # @return [true, false]
  def is_mine(user)
    user.id == self.user.id
  end

  def as_json(options = {})
    super(options.merge(except: [:user_id, :created_at, :updated_at]))
  end

end
