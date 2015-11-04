fs = Npm.require('fs')

Meteor.startup ->
  console.log 'listings: ' + Listings.find().count()
  
  createUsers()
  if Config.smtp
    process.env.MAIL_URL = Config.smtp


    
createUsers = () ->
#  console.log 'users: ' + JSON.stringify Meteor.users.find().fetch()
#  Meteor.users.remove {}
  for u in Config.users
    if !Meteor.users.findOne {'emails.address': u.email}
      console.log 'insert: ' + u.email
      user =
        username: u.name
        emails: [{ address: u.email, verified: true }]
        createdAt: new Date()
      Meteor.users.insert user, (error, id) ->
        Accounts.setPassword id, u.password
        