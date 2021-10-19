class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
    
    
    t.integer :customer_id, null: false, default: ""
    t.string :postcode, null: false, default: ""
    t.string :address, null: false, default: ""
    t.string :name, null: false, default: ""


      t.timestamps
    end
  end
end
