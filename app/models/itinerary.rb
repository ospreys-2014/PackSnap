class Itinerary < ActiveRecord::Base
  validates :start_date, :end_date, presence:true
  validates_numericality_of :end_date, greater_than_or_equal_to: :start_date

  has_many :travel_dates
  has_many :weathers, through: :travel_dates
  has_one :location
  belongs_to :trip

end
