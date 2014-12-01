class Itinerary < ActiveRecord::Base
  validates :start_date, :end_date, presence:true
  validate :start_date_before_or_equal_to_end_date

  has_many :travel_dates
  has_many :weathers, through: :travel_dates
  has_one :location
  belongs_to :trip

 
 	def start_date_before_or_equal_to_end_date
 		errors.add(:end_date, " must be same or more than start_date") if end_date<start_date
 	end
end
