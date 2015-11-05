Meteor.subscribe 'queries', Meteor.userId()

Template.queries.helpers
  queries: () -> Queries.find()


Template.queries.events
  'click #queries .edit': (event, template) ->
    FlowRouter.go "/queries/#{@_id}"
  'click #queries .delete': (event, template) ->
    if confirm 'Really?'
      Queries.remove @_id

Template.query.helpers
  query: () ->
    _id = FlowRouter.getParam('_id')
    Queries.findOne {_id: _id}
  queryText: () ->
    _id = FlowRouter.getParam('_id')
    query = Queries.findOne {_id: _id}
    JSON.parse JSON.stringify query.queryText

Template.query.events
  'click #query .save': (event, template) ->
    event.preventDefault()
    _id = template.find('#_id').value
    obj =
      customer_email: template.find('#customer_email').value
      customer_tel: template.find('#customer_tel').value
      queryText: template.find('#queryText').value
    Queries.update {_id: _id}, {$set: obj}
    FlowRouter.go '/queries'
  'click #query .delete': (event, template) ->
    event.preventDefault()
    if confirm 'Really?'
      _id = template.find('#_id').value
      Queries.remove _id
      FlowRouter.go '/queries'
