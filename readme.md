Assignment 1 for Carlypso 

### Import listing data
mongoimport -h localhost:3001 --db meteor --collection listings --type json --file data/listings.json --jsonArray 
Mongoimport did not work: exception:read error, or input line too long (max length: 16777216). Maybe there is a version problem, so do it with JSONStream. Updating MongoDB solved the problem and the above works.
#### To do it remotely:
http://www.meteorpedia.com/read/Mongo#!
mongoimport -u client -h production-db-b2.meteor.io:27017 -d myapp_meteor_com -p passwordthatexpiresreallyfast /pathtofile 

### Literature
http://docs.meteor.com/#/full
http://fortawesome.github.io/Font-Awesome/icons/
https://kadira.io/academy/meteor-routing-guide/content/rendering-blaze-templates
https://github.com/kadirahq/flow-router
https://github.com/zvictor/meteor-mongo-server/
https://select2.github.io/examples.html
http://momentjs.com/docs/

### Packages
coffeescript 
less 
kadira:flow-router 
kadira:blaze-layout 
accounts-password 
accounts-ui check 
fortawesome:fontawesome 
meteorhacks:npm 
natestrauser:select2
mongodb-server-aggregation
momentjs:moment
email