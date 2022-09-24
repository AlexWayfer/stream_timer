# frozen_string_literal: true

## Require application
require_relative 'application'

## Require project directories, define routes, etc.
ST::Application.setup

config = ST::Application.config

## Use session middleware
use Rack::Session::Cookie, config[:session][:cookie] if config[:session]

## Middleware for exceptions about too large cookies
use Rack::Protection::MaximumCookie

## Access Logger
use Rack::CommonLogger, ST::Application.logger

## Aliases for rack-console
if ENV['RACK_CONSOLE']
	ST::App = ST::Application
	## Some models, for example
end

## Remove invalid UTF-8 characters from requests
use Rack::UTF8Sanitizer

## Remove trailing slashes from request path (and redirect)
# use Rack::RemoveTrailingSlashes

## Parse body as pointed out in Content-type
## https://github.com/rack/rack-contrib/issues/183
# use Rack::JSONBodyParser

## CSRF
## Rescued and reported by `lowlevel_error_handler` in Puma config
use Rack::Csrf, raise: true

## Authentication via third-party providers
use OmniAuth::Builder do
	## https://github.com/omniauth/omniauth/issues/1087
	# provider :developer if config[:environment] == 'development'

	provider :twitch,
		config[:twitch][:client_id], config[:twitch][:client_secret]
	# redirect_uri: 'http://localhost:3000/auth/twitch/callback'

	provider :google_oauth2,
		config[:google][:client_id], config[:google][:client_secret]
end

## Run application
run ST::Application
