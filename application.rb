# frozen_string_literal: true

## Require gems
require 'bundler/setup'
Bundler.require(
	:system, :server, :database, :translations, :forms, :views, :assets, :mails, :auth, :others
)

require 'erubi/capture_end'
require 'voight_kampff/rack_request'

## Require libs

### For $RS constant:
### http://ruby-doc.org/stdlib/libdoc/English/rdoc/English.html
require 'English'

require 'logger'

### For PP.pp (differs from `pp` by arguments (width))
require 'pp'

# require 'money/bank/google_currency'

require_relative 'constants'

module StreamTimer
	## Class for application
	class Application < Flame::Application
		class << self
			include Memery

			memoize def logger
				::Logger.new(
					development_or_toys ? $stdout : File.join(config[:stdout_file])
				)
			end

			def db_connection
				connection = ::Sequel.connect config[:database]

				Config::Processors::Sequel::EXTENSIONS.each do |extension_name|
					connection.extension extension_name
				end

				connection.loggers << logger if development_or_toys

				## Freeze DB (not for `toys console`)
				connection.freeze unless ENV['RACK_CONSOLE']

				connection
			end
			memoize :db_connection

			memoize def shrine_uploaders
				{
					# image: Class.new(::Shrine),
					# document: Class.new(::Shrine)
				}
			end

			def setup
				## Initialize Sequel connection before models requiring
				db_connection

				## Require dirs
				require_dirs APP_DIRS, ignore: [%r{config/puma.rb}, %r{lib/\w+/spec/}]

				class_exec do
					mount Site::Public, '/'
					mount Site::TimerController, '/timer'
				end
			end

			private

			memoize def development_or_toys
				(config[:environment] == 'development') || (File.basename($PROGRAM_NAME) == 'toys')
			end
		end

		require "#{config[:config_dir]}/main"
	end
end
