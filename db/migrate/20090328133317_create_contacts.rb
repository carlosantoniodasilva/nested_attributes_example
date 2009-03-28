class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :kind
      t.string :description
      t.references :person

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
