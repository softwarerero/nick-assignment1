Template.menu.onRendered () ->
  login = document.getElementById 'login-buttons'
  login?.className += " signIn"