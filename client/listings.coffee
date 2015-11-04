Template.listings.onCreated ->
  Meteor.call 'listingYears', (error, data) ->
    Session.set 'years', data
  Meteor.call 'listingMakes', {years: [new Date().getFullYear()]}, (error, data) ->
    Session.set 'makes', data
  Meteor.call 'listingColors', (error, colors) ->
    Session.set 'colors', colors

Template.listings.onRendered ->
  clear this, ['makes', 'models', 'trims']
#  $('select').select2 {}

Template.listings.helpers
  years: () -> Session.get 'years'
  makes: () -> Session.get 'makes'
  models: () -> Session.get 'models'
  trims: () -> Session.get 'trims'
  colors: () -> Session.get 'colors'
  yearSelected: (y) -> if y is new Date().getFullYear() then 'selected' else ''
  isSearchEnabled: -> Session.get 'isSearchEnabled'
    

Template.listings.events
  'change .years': (event, template) ->
    clear template, ['makes', 'models', 'trims']
    data = templateData template
    Meteor.call 'listingMakes', data, (error, data) ->
      Session.set 'makes', data
  'change .makes': (event, template) ->
    clear template, ['models', 'trims']
    data = templateData template
    Meteor.call 'listingModels', data, (error, data) ->
      Session.set 'models', data
  'change .models': (event, template) ->
    clear template, ['trims']
    data = templateData template
    Meteor.call 'listingTrims', data, (error, data) ->
      Session.set 'trims', data
  'change .trims': (event, template) ->
    Session.set 'isSearchEnabled', true
    data = templateData template
    Meteor.call 'listingValueAdded', data, (error, data) ->
      if data
        $('#value-added').children().remove()
        container = $('#value-added')        
        for option in data
          createCheckbox container, option
#  'change #value-added input[type="checkbox"]': (event, template) ->
#    bool = $('#value-added input[type="checkbox"]:checked').length > 0
#    Session.set 'isSearchEnabled', bool
  'click .search': (event, template) ->
    data = templateData template
    valueAddedData template, data
    Meteor.call 'searchListings', data, (error, data) ->
      Session.set 'listings', data

Template.listingResults.helpers
  listings: -> Session.get 'listings'
  image: (url) -> if url then "<img src='#{url}'/>" else ""


clear = (template, what) -> 
  for w in what
    Session.set w, null
    $(template.find('.'+w))?.val(null).trigger("change");
  $('#value-added').children().remove()
  Session.set 'isSearchEnabled', false
  Session.set 'listings', null

templateData = (template, what) ->
  ret = {}
  for w in ['years', 'makes', 'models', 'trims', 'colors']
    value = $(template.find('.'+w))?.val()
    if value
      if w is 'years'
        value = years2Int value
      ret[w] = value 
  ret
  
valueAddedData = (template, data) ->
  values = $(template.findAll('#value-added input[type="checkbox"]:checked'))
  value_added = for v in values
    v?.value
  if value_added.length
    data.value_added = value_added

years2Int = (years) ->
  if years
    for y in years
      parseInt y
  else
    []
  
createCheckbox = (container, option) ->
  checkbox = document.createElement 'input'
  checkbox.type = "checkbox"
  checkbox.name = option
  checkbox.id = option
  checkbox.value = option
  label = document.createElement 'label'
  label.htmlFor = option
  label.appendChild document.createTextNode option
  container.append checkbox
  container.append label
