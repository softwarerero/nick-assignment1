fs = Npm.require('fs')

Meteor.startup ->
  console.log 'listings: ' + Listings.find().count()
  
  createUsers()
  if Config.smtp
    process.env.MAIL_URL = Config.smtp

      
createUsers = () ->        
  #Meteor.listings.remove {}
  if !Meteor.users.find().count()
    for u in Config.users
      user =
        username: u.name
        emails: [{ address: u.email, verified: true }]
        createdAt: new Date()
      Meteor.users.insert user, (error, id) ->
        Accounts.setPassword id, u.password        