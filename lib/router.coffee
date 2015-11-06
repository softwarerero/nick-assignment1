FlowRouter.route '/',
  action: () ->
    BlazeLayout.render "mainLayout", {content: "listings"}

FlowRouter.route '/queries',
  action: () -> BlazeLayout.render "mainLayout", {content: "queries"}

FlowRouter.route '/queries/:_id',
  action: () -> BlazeLayout.render "mainLayout", {content: "query"}

FlowRouter.route '/results/:_id',
  action: () -> BlazeLayout.render "mainLayout", {content: "results"}

FlowRouter.route '/logout',
  action: () ->
    Meteor.logout()
    FlowRouter.go '/'
    