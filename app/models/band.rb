class Band < ActiveRecord::Base
  has_many :albums, dependent: :destroy
  has_many :tracks, through: :albums

  def to_s
    name
  end
end
