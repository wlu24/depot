# $ rails generate migration add_quantity_to_line_items quantity:integer

class AddQuantityToLineItems < ActiveRecord::Migration[5.1]
  def change
    add_column :line_items, :quantity, :integer, default: 1
  end
end
