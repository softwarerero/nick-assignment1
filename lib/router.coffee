FlowRouter.route '/',
  action: () ->
    BlazeLayout.render "mainLayout", {content: "listings"}
#    console.log '/: ' + Meteor.userId()
#    if Meteor.userId()
#      BlazeLayout.render "mainLayout", {content: "listings"}
#    else
#      BlazeLayout.render "mainLayout", {content: "home"}

#FlowRouter.route '/listings',
#  action: () -> BlazeLayout.render "mainLayout", {content: "listings"}
    