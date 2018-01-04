require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success

    # The following 4 assert_select's verify that the response contains the layout

    # Looks for an element named a that’s contained in a nav element that has
    # the class side_nav
    assert_select 'nav.side_nav a', minimum: 4
    
    # Verifies that there are three li elements inside a ul with the class
    # catalog, which is itself inside the main element
    assert_select 'main ul.catalog li', 3

    # Verifies that there’s an h2 element with the title of the Ruby book that
    # we’d entered previously
    assert_select 'h2', 'Programming Ruby 1.9'

    # Verifies that the price is formatted correctly
    assert_select '.price', /\$[,\d]+\.\d\d/

  end

end
