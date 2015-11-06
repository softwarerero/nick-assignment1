referenceDate = (query) ->
  date = if query.lastChecked
    moment query.lastChecked
  else
    moment().subtract(Config.checkForQueriesMin, 'minutes')
  date.toDate()

checkForQueries = ->
  queries = Queries.find()
  queries.forEach (query) ->
    date = referenceDate query
    queryText = JSON.parse query.queryText
    # debug - remove this
    Listings.update queryText, {$set: {created_at: date}}, {multi: true}
    queryText.created_at = {$gt: date}
    listings = Listings.find queryText
    if listings.count()
      sendEmail query, listings.count()
      Queries.update {_id: query._id}, {$set: {lastChecked: date}}


sendEmail = (query, listingCount) ->
  email = query.email
  console.log "email: " + email
  if Match.test email, String
    console.log 'send'
    
    text = 'Customer Email: ' + query.customer_email
    text += '\nCustomer Tel: ' + query.customer_tel
    text += '\n\n'
    text += "You have #{listingCount} new results, see #{Meteor.absoluteUrl()}results/#{query._id}"
    
    Email.send
      to: email
      from: Config.emailFrom
      subject:  "#{Config.appName}: You've got prospects!"
      text: text

checkForQueries()
Meteor.setInterval checkForQueries, Config.checkForQueriesMin * 60 * 1000
      