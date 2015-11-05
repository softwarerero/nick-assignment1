# Publications
#Meteor.publish "listings", (userId) ->
#  Listings.find {}

Meteor.publish "queries", (userId) ->
  console.log 'queries.publish: ' + userId
#  Queries.find {userId: userId}
  Queries.find {}
  
#Meteor.publish "settingsAndFiles", (userId) ->
#  check(userId, String)
#  return [
#    Collections.Settings.find {userId: userId}, {fields: {secretInfo: 0}}
#    Collections.TemplateFiles.find
#      $query: {'metadata.owner': userId}
#      $orderby: {uploadedAt: -1}
#  ] 