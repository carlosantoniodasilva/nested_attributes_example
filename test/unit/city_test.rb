require 'test_helper'

class CityTest < ActiveSupport::TestCase

  def setup
    @valid_attributes = {
      :name => 'City name'
    }
  end

  test 'should create a valid city' do
    assert City.create!(@valid_attributes)
  end

  test 'should require name' do
    city = City.new
    assert city.invalid?
    assert city.errors.on(:name)
  end

  test 'should has_many people' do
    association = City.reflect_on_association(:people)
    assert !association.nil?
    assert association.macro == :has_many
  end
end

