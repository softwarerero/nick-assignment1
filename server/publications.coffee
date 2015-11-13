# Publications
Meteor.publish "queries", (userId) ->
  Queries.find {}
  
#Meteor.publish "settingsAndFiles", (userId) ->
#  check(userId, String)
#  return [
#    Collections.Settings.find {userId: userId}, {fields: {secretInfo: 0}}
#    Collections.TemplateFiles.find
#      $query: {'metadata.owner': userId}
#      $orderby: {uploadedAt: -1}
#  ] 