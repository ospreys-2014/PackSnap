class Itinerary < ActiveRecord::Base
  validates :start_date, :end_date, presence:true

  has_many :travel_dates
  has_many :weathers, through: :travel_dates
  has_one :location
  belongs_to :trip
end
