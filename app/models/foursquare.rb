module Foursquare

  BASE_URL = "http://api.foursquare.com/v2/venues/explore?"

  def establish_restaurants
    self.restaurants.clear

    get_restaurants.each do |restaurant|
      data = restaurant["venue"]
      next if Restaurant.duplicate(data['id']).present?

      rest = Restaurant.create!(
                            name: data['name'],
                            contact: data['contact'],
                            location: data['location']['address'],
                            verified: data['verified'],
                            photos: data['photos'],
                            uniq_key: data['id']
      )
      self.restaurants << rest
    end
  end

  def get_restaurants
    venue = JSON.load(get_restaurants_raw.body)
    venue.map {|v| venue['response']['groups'].first['items']}.flatten
  end

  def get_restaurants_raw
    params = { client_id: "N305BG0OD40SDO2IZKO4AX0ZPWGG35K5D0JCNY3EIJ1XAETQ",   #should be added to secrets
               client_secret: "S5Q0EK54VZDRE4K5OKLQ23VSWPGTKHQFMVVWFBM5TWWJGEHH",
               ll: "#{latitude},#{longitude}",
               radius: "1234",
               v: "20130118" }.to_query

    HTTParty.get(BASE_URL, :query => params)
  end
end
