Accounts.config
  forbidClientAccountCreation: true

Accounts.onLogin ->
  FlowRouter.go '/'

Deps.autorun (computation) ->
#  if !computation.firstRun
  if !Meteor.user()
    FlowRouter.go '/'

    