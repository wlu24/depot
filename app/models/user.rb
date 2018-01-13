class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  # tells Rails to validate that the two password (when user filling out
  # the form) match
  #
  # This line was added because we specified password:digest when we run
  # $ rails generate scaffold User name:string password:digest
  has_secure_password



  # ActiveRecord hook method. Called after the SQL delete is executed.
  after_destroy :ensure_an_admin_remains

  class Error < StandardError
  end

   private
     def ensure_an_admin_remains
       if User.count.zero?
         # This exception serves two purposes. First, because it’s raised inside
         # a transaction, it causes an automatic rollback. By raising the
         # exception if the users table is empty after the deletion, we undo the
         # delete and restore that last user. Second, the exception signals the
         # error back to the controller, where we use a rescue_from block to
         # handle it and report the error to the user in the notice.
         raise Error.new "Can't delete last user"
       end
     end

end
