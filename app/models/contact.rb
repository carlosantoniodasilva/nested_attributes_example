class Contact < ActiveRecord::Base
  KINDS = %w(home_phone work_phone email url)
  belongs_to :person

  validates_presence_of :kind, :description
  validates_inclusion_of :kind, :in => KINDS
end

