class Card < ApplicationRecord

  belongs_to :bunch

  def as_json(options = {})
    super(options.merge(except: [:bunch_id, :created_at, :updated_at]))
  end

end