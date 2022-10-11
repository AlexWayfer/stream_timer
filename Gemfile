# frozen_string_literal: true

source 'https://rubygems.org'

group :system do
	gem 'bundler'
	gem 'gorilla_patch'
	# gem 'httpx'
	gem 'alt_memery'
	gem 'pry-byebug'
	# gem 'rubyzip'
	gem 'uuid'
end

group :server do
	gem 'flame', '~> 5.0.0.rc8'
	gem 'flame-flash', '~> 3.0.1.rc2'
	gem 'flame-menu', github: 'AlexWayfer/flame-menu'

	gem 'puma'

	## https://github.com/davidcelis/rack-console/pull/3
	gem 'rack-console',
		github: 'AlexWayfer/rack-console',
		branch: 'update_rack_to_3'

	## https://github.com/rack/rack-contrib/issues/183
	# gem 'rack-contrib'

	gem 'rack_csrf', require: 'rack/csrf'

	## https://github.com/mwpastore/rack-protection-maximum_cookie/pull/4
	gem 'rack-protection-maximum_cookie',
		github: 'AlexWayfer/rack-protection-maximum_cookie',
		branch: 'update_rack_dependency'

	## https://github.com/rack/rack-session/pull/12#issuecomment-1257034837
	gem 'rack-session', github: 'rack/rack-session'

	gem 'rack-slashenforce'

	## https://github.com/whitequark/rack-utf8_sanitizer/pull/66
	gem 'rack-utf8_sanitizer',
		github: 'whitequark/rack-utf8_sanitizer'
end

group :development do
	gem 'letter_opener'
end

group :linter do
	gem 'bundler-audit'
	gem 'rubocop'
	gem 'rubocop-performance'
	gem 'rubocop-rspec'
	gem 'rubocop-sequel'
end

group :database do
	gem 'pg'
	gem 'sequel'
	gem 'sequel-enum_values', require: 'sequel/plugins/enum_values'
	gem 'sequel_pg', require: 'sequel'
	gem 'sequel_secure_password'
end

group :translations do
	gem 'flame-r18n', '~> 3.0.0.rc1'
end

group :forms do
	gem 'formalism'
	gem 'formalism-model_forms'
	gem 'formalism-r18n_errors'
	gem 'formalism-sequel_transactions'
end

group :views do
	gem 'erubi', require: 'tilt/erubi'
end

group :mails do
	# gem 'email_address'
	gem 'kramdown'
	gem 'mail'
	gem 'net-smtp'
end

group :auth do
	gem 'omniauth'
	gem 'omniauth-google-oauth2'
	gem 'omniauth-twitch', github: 'deanpcmad/omniauth-twitch', branch: 'fix-auth'

	## For updating avatars
	## Wait for a new release with Faraday 2
	gem 'twitch-api', github: 'mauricew/ruby-twitch-api'
	gem 'google-apis-people_v1'
end

group :test do
	# gem 'database_cleaner'
	# gem 'fabrication'
	gem 'oga'
	# gem 'page-object'
	gem 'rack-test'
	# gem 'retriable'
	gem 'rspec'
	gem 'warning'
	# gem 'watir'
end

group :others do
	# gem 'faker'
	gem 'flame-sentry_context'
	# gem 'kramdown'
	# gem 'retries',
	# gem 'money-oxr',
	# 	## https://github.com/edlebert/money-oxr/pull/7
	# 	github: 'AlexWayfer/money-oxr', branch: 'add_flock_for_cache'
	# 	## https://github.com/ooyala/retries/pull/9
	# 	github: 'AlexWayfer/retries', branch: 'v2'
	gem 'shrine'
	# gem 'tzinfo'
	# gem 'tzinfo-data'
	## https://github.com/biola/Voight-Kampff/pull/38
	gem 'voight_kampff', github: 'AlexWayfer/Voight-Kampff', branch: 'v2'
end

group :toys do
	gem 'toys'

	gem 'benchmark_toys'
	gem 'config_toys'
	gem 'flame_deploy_toys'
	gem 'flame_generate_toys'
	gem 'flame_routes_toys'
	gem 'flame_server_toys'
	gem 'icomoon_toys'
	gem 'locales_toys'
	gem 'psql_toys'
	gem 'rack_console_toys'
	gem 'sequel_migrations_toys'
	gem 'static_files_toys'
end
