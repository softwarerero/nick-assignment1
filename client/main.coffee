Template.menu.onRendered () ->
  login = document.getElementById 'login-buttons'
  login?.className += " signIn"


Template.onlyIfLoggedIn.helpers
  authInProcess: -> Meteor.loggingIn()
  canShow: -> !!Meteor.user()