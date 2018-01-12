class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  # tells Rails to validate that the two password (when user filling out
  # the form) match
  #
  # This line was added because we specified password:digest when we run
  # $ rails generate scaffold User name:string password:digest
  has_secure_password
end
