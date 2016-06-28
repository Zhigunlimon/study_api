require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :address }
  it { should have_and_belong_to_many :restaurants }

  context 'fails create user with invalid address' do

    it 'should not be created when invalid' do
      expect { create(:user, address: 'njnjnjnjnjnjn') }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Address is not valid')
    end

    it 'should not be created when empty' do
      expect { create(:user) }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Address can't be blank")
    end
  end

  context 'create user with valid address and searches for restaurants' do

    let!(:user) { create(:user, address: '229 West 43rd St., New York City, NY 10036') }

    it 'assigns restauraunts to user' do
      expect(user.restaurants).to_not be_empty
    end

    it 'should not change users.restaurants if address did not change' do
      before_restaurants = user.restaurants
      user.update_attributes(first_name: 'NEW')
      expect(user.restaurants.first).to be(before_restaurants.first)
    end

    it 'should change users.restaurants if address changed' do
      @before_restaurant === user.restaurants.first
      user.update_attributes(address: 'paris eiffel tower')
      expect(user.restaurants.first).to_not be(@before_restaurant)
    end

    it 'The distance between user and restaurant should not limit 1234m' do
      user_address = "#{user.latitude},#{user.longitude}"
      restaurant = user.restaurants.shuffle.sample
      restaurant_address = Geocoder.coordinates(restaurant.location)


      expect(Geocoder::Calculations.distance_between(user_address, restaurant_address)).to be <= 1234
    end
  end
end
