class User < ApplicationRecord
  has_many :groups, dependent: :destroy
end