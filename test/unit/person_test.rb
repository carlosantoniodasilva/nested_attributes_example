require 'test_helper'

class PersonTest < ActiveSupport::TestCase

  def setup
    @valid_attributes = {
      :name => 'Person name',
      :city_id => 1
    }
  end

  test 'should create a valid person' do
    assert Person.create!(@valid_attributes)
  end

  test "should require name" do
    person = Person.new
    assert person.invalid?
    assert person.errors.on(:name)
  end

  test 'should has_many contacts' do
    association = Person.reflect_on_association(:contacts)
    assert !association.nil?
    assert association.macro == :has_many
  end

  test 'should belongs_to a city' do
    association = Person.reflect_on_association(:city)
    assert !association.nil?
    assert association.macro == :belongs_to
  end

  # Contacts
  def create_person_with_nested_contacts
    @valid_attributes.merge!(
      :contacts_attributes => {
         'new1' => { :kind => 'email', :description => 'contact 1' },
         'new2' => { :kind => 'email', :description => 'contact 2' }
      }
    )
    @person = Person.create!(@valid_attributes)
  end

  test 'should create a person with nested' do
    create_person_with_nested_contacts
    assert !@person.new_record?
  end

  test 'should create nested contacts' do
    create_person_with_nested_contacts
    assert @person.contacts.size == 2
  end

  test "should define nested contacts attributes" do
    create_person_with_nested_contacts
    assert @person.contacts.first.kind == 'email'
    assert @person.contacts.first.description == 'contact 1'
    assert @person.contacts.second.kind == 'email'
    assert @person.contacts.second.description == 'contact 2'
  end

  test "should allow editing nested contacts" do
    create_person_with_nested_contacts
    id = @person.contacts.first.id
    @person.contacts_attributes = { id.to_s => { :id => id.to_s, :description => 'new description' } }
    assert @person.contacts.detect{ |contact| contact.id == id }.description == 'new description'
    assert @person.save
    assert @person.contacts.find(id).description == 'new description'
  end

  test "should allow destroying a nested contact" do
    create_person_with_nested_contacts
    id = @person.contacts.first.id
    @person.contacts_attributes = { id.to_s  => { :id => id.to_s, :_delete => "1" } }
    assert @person.contacts.detect{ |contact| contact.id == id }.marked_for_destruction?
    assert @person.save
    assert @person.contacts.reload.size == 1
  end

  test "should ignore nested contacts without description" do
    create_person_with_nested_contacts
    @person.contacts_attributes = { 'new3' => { :kind => 'email', :description => '' } }
    assert @person.contacts.size == 2
  end

  test "should generate errors when a nested contact is invalid" do
    create_person_with_nested_contacts
    @person.contacts_attributes = { 'new3' => { :kind => 'any invalid kind', :description => 'bla bla bla' } }
    assert @person.invalid?
    assert @person.errors.on(:contacts_kind)
  end

  # City
  def create_person_with_nested_city
    @valid_attributes.merge!(
      :city_attributes => { :name => 'City 1' }
    )
    @person = Person.create!(@valid_attributes)
  end

  test 'should create a person with nested city' do
    create_person_with_nested_city
    assert !@person.new_record?
  end

  test 'should create nested city' do
    create_person_with_nested_city
    assert !@person.city.nil?
    assert !@person.city.new_record?
  end

  test "should define nested city attributes" do
    create_person_with_nested_city
    assert @person.city.name == 'City 1'
  end

  test "should allow editing nested city" do
    create_person_with_nested_city
    id = @person.city.id
    @person.city_attributes = { :name => 'New City Name' }
    assert @person.city.name == 'New City Name'
    assert @person.save
    assert @person.city.reload.name == 'New City Name'
  end

  test "should not allow destroying a nested city" do
    create_person_with_nested_city
    city = @person.city
    @person.city_attributes = { city.id.to_s  => { :id => city.id.to_s, :_delete => "1" } }
    assert !@person.city.marked_for_destruction?
    assert @person.save
    assert !@person.city.reload.nil?
    assert @person.city == city
  end

  test "should ignore nested city without name" do
    create_person_with_nested_city
    city = @person.city
    @person.city_attributes = { 'new3' => { :name => '' } }
    assert @person.save
    assert @person.city == city
  end
end

