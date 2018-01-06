class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  enum pay_type: {
    "Check"          => 0,
    "Credit card"    => 1,
    "Purchase order" => 2
  }

  validates :name, :address, :email, presence: true

  # An application can’t assume that it’s being fed values from the forms it
  # creates. Nothing is stopping a malicious user from submitting form data
  # directly to the application, bypassing our form. If the user sets an
  # unknown payment type, that user might conceivably get our products for free.
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil

      # self (an instance of Order) is omitted
      #
      # Appending each new line item to the line_items collection for the order
      # hands the responsibility for key management over to Rails.
      line_items << item   # order.line_items.create(item)
    end
  end
end
