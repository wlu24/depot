require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  # provides the method perform_enqueued_jobs()
  include ActiveJob::TestHelper

  test "check routing number" do

    # clear out any orders in the test database that might be hanging around
    # from previous test runs
    LineItem.delete_all
    Order.delete_all

    visit store_index_url

    first('.catalog li').click_on 'Add to Cart'

    click_on 'Checkout'

    fill_in 'order_name', with: 'Dave Thomas'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'dave@example.com'

    assert_no_selector "#order_routing_number"

    select 'Check', from: 'pay_type'

    assert_selector "#order_routing_number"

    fill_in "Routing #", with: "123456"
    fill_in "Account #", with: "987654"


    # Since this test is about the user’s experience end-to-end, you don’t need
    # to look at the jobs that have been queued—instead we need to make sure they
    # are executed. It’s sufficient to assert the results of those jobs having
    # been executed. To that end, the method perform_enqueued_jobs() will perform
    # any jobs that get enqueued inside the block of code given to it.
    perform_enqueued_jobs do
      click_button "Place Order"
    end



    # Check that an order was created in the way you expect by locating the
    # created order and asserting that the values provided in the checkout form
    # were properly saved.
    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first

    assert_equal "Dave Thomas",       order.name
    assert_equal "123 Main Street",   order.address
    assert_equal "dave@example.com",  order.email
    assert_equal "Check",             order.pay_type
    assert_equal 1, order.line_items.size


    # Check that the mail was sent. In the test environment, Rails doesn’t
    # actually deliver mail but instead saves it in an array available via
    # ActionMailer::Base.deliveries(). The objects in there respond to various
    # methods that allow you to examine the email.
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"],                  mail.to
    assert_equal 'Sam Ruby <depot@example.com>',        mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation",  mail.subject

  end
end
