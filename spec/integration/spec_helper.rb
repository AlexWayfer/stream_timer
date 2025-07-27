# frozen_string_literal: true

require 'rack/test'

require 'warning'

Warning.ignore(:missing_ivar, Gem.loaded_specs['sequel'].full_gem_path)

## They're generated
Warning.ignore(
	%i[mismatched_indentations unused_var]
)

shared_context 'with Rack Test' do
	include Rack::Test::Methods

	let(:app) do
		require_relative '../../application'

		app = ST::Application

		## Require project directories, define routes, etc.
		app.setup

		app
	end
end
