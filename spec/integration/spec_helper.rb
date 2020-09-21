# frozen_string_literal: true

require 'rack/test'

require 'warning'

Warning.ignore(:missing_ivar, Gem.loaded_specs['sequel'].full_gem_path)

## https://github.com/getsentry/sentry-ruby/issues/1036
Warning.ignore(
	/loading in progress, circular require considered harmful/,
	Gem.loaded_specs['sentry-raven'].full_gem_path
)

shared_context 'with Rack Test' do
	include Rack::Test::Methods

	let(:app) do
		root_dir = '../..'
		require_relative "#{root_dir}/application"
		require_relative "#{root_dir}/routes"

		ST::Application
	end
end
