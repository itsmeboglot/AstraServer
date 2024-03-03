class Group < ApplicationRecord

  belongs_to :user
  has_many :bunches, dependent: :destroy
  validates :name, presence: true

  # @return [true, false]
  def belongs_to?(user)
    user.id == self.user_id
  end

  def as_json(options = {})
    super(options.merge(except: [:user_id, :created_at, :updated_at]))
  end

end
