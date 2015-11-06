Template.results.helpers
  query: () ->
    _id = FlowRouter.getParam('_id')
    query = Queries.findOne {_id: _id}
    Meteor.call 'searchResult', query.queryText, (error, listings) ->
      Session.set 'listings', listings
    query
    
