# frozen_string_literal: true

## Require application
require_relative 'application'

## Require routes
require_relative 'routes'

## Use session middleware
if ST::Application.config[:session]
	use Rack::Session::Cookie, ST::Application.config[:session][:cookie]
end

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
use Rack::JSONBodyParser

## CSRF
## Rescued and reported by `lowlevel_error_handler` in Puma config
use Rack::Csrf, raise: true

## Run application
run ST::Application
