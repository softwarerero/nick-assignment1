Meteor.methods
 
  listingYears: -> (Listings.distinct 'year').sort().reverse()
  listingColors: -> (Listings.distinct 'color').sort()
  listingMakes: (data) ->
    if Match.test data, {years: [Number], colors: Match.Optional Match.Any}
      listings = Listings.find {year: {$in: data.years}}, {fields: {make: 1}}
      uniqueSorted pickVal listings, 'make'
  listingModels: (data) ->
    if Match.test data, {years: [Number], makes: [String], colors: Match.Optional Match.Any}
      listings = Listings.find {year: {$in: data.years}, make: {$in: data.makes}}, {fields: {model: 1}}
      uniqueSorted pickVal listings, 'model'
  listingTrims: (data) ->
    if Match.test data, {years: [Number], makes: [String], models: [String], colors: Match.Optional Match.Any}
      listings = Listings.find {year: {$in: data.years}, make: {$in: data.makes}, model: {$in: data.models}}, {fields: {trim: 1}}
      uniqueSorted pickVal listings, 'trim'
  listingValueAdded: (data) ->
    if Match.test data, {years: [Number], makes: [String], models: [String], trims: [String], colors: Match.Optional Match.Any}
      listings = Listings.find {year: {$in: data.years}, make: {$in: data.makes}, model: {$in: data.models}, trim: {$in: data.trims}}, {fields: {condition_report: 1}}
      condition_report = pickVal listings, 'condition_report'
      uniqueSorted pickValueAdded condition_report
  searchListings: (data) ->
    query = listingQuery data
    query.sold = false
    if query
      listings = Listings.find query, {limit: Config.maxListings}
      listings.fetch()
  searchResult: (queryText) ->
    data = JSON.parse queryText
    if data
      listings = Listings.find data, {limit: Config.maxListings}
      listings.fetch()
  saveSearch: (data) ->
    query = listingQuery data
    query.sold = false
    if query
      queryText = JSON.stringify query
#      console.log JSON.stringify {userId: Meteor.userId(), date: new Date, queryText: queryText}
      email = Meteor.user().emails[0].address
      Queries.insert {userId: Meteor.userId(), date: new Date, email: email, queryText: queryText}, (error, _id) ->
        _id
      
      
pickVal = (collection, name) ->
  for o in collection.fetch()
    o[name]

pickValueAdded = (condition_report) ->
  ret = []
  for o in condition_report
    ret = ret.concat o.value_added
  ret
    
uniqueSorted = (arr) ->
  ret = arr.filter (value, index, array) ->
    array.indexOf(value, index + 1) < 0
  ret.sort()

listingQuery = (data) ->
  validation = {years: [Number], makes: [String], models: [String], trims: [String], value_added: Match.Optional([String]), colors: Match.Optional([String]), sold: Match.Optional(Boolean)}
  if Match.test(data, validation)
    query =
      year: {$in: data.years}
      make: {$in: data.makes}
      model: {$in: data.models}
      trim: {$in: data.trims}
    if data.value_added
      query["condition_report.value_added"] = {$in: data.value_added}
    if data.colors
      query.color = {$in: data.colors}
    query

