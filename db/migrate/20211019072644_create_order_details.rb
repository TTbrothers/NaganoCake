class CreateOrderDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :order_details do |t|

    t.integer :order_id, null: false, default: ""
    t.integer :item_id, null: false, default: ""
    t.integer :price, null: false, default: ""
    t.integer :amount, null: false, default: ""
    t.integer :status, null: false, default: "0"
    

    t.timestamps
    end
  end
end
