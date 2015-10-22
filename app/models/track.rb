class Track < ActiveRecord::Base
  belongs_to :album
  has_one :band, through: :album

  def to_s
    title
  end
end
