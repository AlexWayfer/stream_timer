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
	gem 'flame', '~> 5.0.0.rc6'
	gem 'flame-flash', '~> 3.0.1.rc1'
	gem 'flame-menu', github: 'AlexWayfer/flame-menu'
	gem 'puma'
	gem 'rack-contrib'
	gem 'rack_csrf', require: 'rack/csrf'
	## https://github.com/mwpastore/rack-protection-maximum_cookie/pull/4
	gem 'rack-protection-maximum_cookie',
		github: 'AlexWayfer/rack-protection-maximum_cookie',
		branch: 'update_rack_dependency'
	gem 'rack-slashenforce'
	gem 'rack-utf8_sanitizer'
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
	gem 'flame-raven_context'
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
