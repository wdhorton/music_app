class Track < ActiveRecord::Base
  belongs_to :album
  has_one :band, through: :album
  has_many :notes

  def to_s
    title
  end
end
