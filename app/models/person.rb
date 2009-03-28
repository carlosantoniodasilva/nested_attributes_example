class Person < ActiveRecord::Base
  belongs_to :city
  has_many :contacts

  validates_presence_of :name

  accepts_nested_attributes_for :contacts, :allow_destroy => true,
                                :reject_if => proc { |contact| contact['description'].blank? }

  accepts_nested_attributes_for :city,
                                :reject_if => proc { |city| city['name'].blank? }
end

