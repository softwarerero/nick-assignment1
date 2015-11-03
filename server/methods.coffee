Meteor.methods

  listingYears: () ->
    (Listings.distinct 'year').sort().reverse()
  listingMakes: (data) ->
    if Match.test data, {years: [Number]}
      listings = Listings.find {year: {$in: data.years}}, {fields: {make: 1}}
      uniqueSorted pickVal listings, 'make'
  listingModels: (data) ->
    if Match.test data, {years: [Number], makes: [String]}
      listings = Listings.find {year: {$in: data.years}, make: {$in: data.makes}}, {fields: {model: 1}}
      uniqueSorted pickVal listings, 'model'
  listingTrims: (data) ->
    if Match.test data, {years: [Number], makes: [String], models: [String]}
      listings = Listings.find {year: {$in: data.years}, make: {$in: data.makes}, model: {$in: data.models}}, {fields: {trim: 1}}
      uniqueSorted pickVal listings, 'trim'
  listingValueAdded: (data) ->
    if Match.test data, {years: [Number], makes: [String], models: [String], trims: [String]}
      listings = Listings.find {year: {$in: data.years}, make: {$in: data.makes}, model: {$in: data.models}, trim: {$in: data.trims}}, {fields: {condition_report: 1}}
      condition_report = pickVal listings, 'condition_report'
      uniqueSorted pickValueAdded condition_report
  searchListings: (data) ->
    if Match.test data, {years: [Number], makes: [String], models: [String], trims: [String], value_added: [String]}
      query =
        year: {$in: data.years}
        make: {$in: data.makes}
        model: {$in: data.models}
        trim: {$in: data.trims}
        'condition_report.value_added': {$in: data.value_added}
      listings = Listings.find query
      listings.fetch()

      
      
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
