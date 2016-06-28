class User < ActiveRecord::Base
  include Foursquare

  has_and_belongs_to_many :restaurants

  geocoded_by :address

  validates :first_name, :last_name, :address, presence: true

  after_validation :geocode, :if => :address_changed?
  after_validation :lat_changed?
  after_save :establish_restaurants, :if => :address_changed?

  private

  def lat_changed?
    if (self.address_changed?)
      if !(self.latitude_changed?)
        self.errors.add(:address, "is not valid")
        return false
      end
    end
    return true
  end
end
