require 'test_helper'

class ContactTest < ActiveSupport::TestCase

  def setup
    @valid_attributes = {
      :kind => 'email',
      :description => 'contact@test.com',
      :person_id => 1
    }
  end

  test 'should create a valid contact' do
    assert Contact.create!(@valid_attributes)
  end

  [:kind, :description].each do |field|
    test "should require #{field}" do
      contact = Contact.new
      assert contact.invalid?
      assert contact.errors.on(field)
    end
  end

  test 'should require kind to be in possible values' do
    valids = Contact::KINDS
    invalids = %w(any other invalid kind)
    valids.each do |value|
      contact = Contact.new(:kind => value)
      contact.valid?
      assert !contact.errors.on(:kind)
    end
    invalids.each do |value|
      contact = Contact.new(:kind => value)
      contact.valid?
      assert contact.errors.on(:kind)
    end
  end

  test 'should belongs_to a person' do
    association = Contact.reflect_on_association(:person)
    assert !association.nil?
    assert association.macro == :belongs_to
  end
end

