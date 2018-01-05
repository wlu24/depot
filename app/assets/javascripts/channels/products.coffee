App.products = App.cable.subscriptions.create "ProductsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Data has an html attribute that contains the updated HTML 
    # (refer to ProductsController#update at the part of the code where
    # ActionCable is set). You can then use getElementsByTagName() to locate
    # all the main elements on the page. Since our application only has one of
    # these, we can safely grab the first one using [0] and replace its HTML
    # with the received HTML
    document.getElementsByTagName("main")[0].innerHTML = data.html
