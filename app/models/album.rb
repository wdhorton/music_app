class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks, dependent: :destroy

  def to_s
    title
  end
end
