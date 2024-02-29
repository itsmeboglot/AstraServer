class Group < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy

  # @return [true, false]
  def is_mine(user)
    user.id == self.user.id
  end
end