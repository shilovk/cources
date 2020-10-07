require 'dotenv'
require 'rest-client'
require 'json'

Dotenv.load 'credentials.env'

response = RestClient.post 'https://s1.teachbase.ru/oauth/token', {
  grant_type: 'client_credentials',
  client_id: ENV['CLIENT_ID'],
  client_secret: ENV['CLIENT_SECRET']
}

token = JSON.parse(response)['access_token']

cources = RestClient.get 'https://s1.teachbase.ru/endpoint/v1/course_sessions', {
  authorization: "Bearer #{token}",
  accept: 'application/json',
  params: { page: 1, per_page: 10 }
}

puts cources
