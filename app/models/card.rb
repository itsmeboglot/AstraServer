class Card < ApplicationRecord

  belongs_to :bunch
  validates :word, :definition, presence: true

  def as_json(options = {})
    super(options.merge(except: [:bunch_id, :created_at, :updated_at]))
  end

end