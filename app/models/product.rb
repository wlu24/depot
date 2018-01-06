class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item


  validates :title, :description, :image_url, presence: true

  # Test against one cent rather than zero because the database stores just two
  # digits after the decimal point, this would end up being zero in the database,
  # even though it would pass the validation if we compared against zero.
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  validates :title, uniqueness: true, length: {minimum: 10}

  # Check that the URL ends with one of .gif, .jpg, or .png
  #
  # Using the allow_blank option to avoid getting multiple error messages when
  # the field is blank.
  validates :image_url, allow_blank: true, format: { with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }


  private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, 'Line Items present')
        throw :abort
      end
    end
end
