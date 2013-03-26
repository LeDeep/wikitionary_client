require 'faraday'
require 'json'

require 'rspec'

require 'webmock/rspec'
require 'rake'
require 'rspec'
require 'shoulda-matchers'
require 'pry'
require 'pry-debugger'

require 'entry'

HEROKU_URL = 'http://wikitionarysmpjl.herokuapp.com/entries'
LOCAL_URL = 'http://localhost:3000/entries'  
