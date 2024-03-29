# frozen_string_literal: true

require 'rack/test'

require 'warning'

Warning.ignore(:missing_ivar, Gem.loaded_specs['sequel'].full_gem_path)

## They're generated
%w[css xpath].each do |lexer_type|
	Warning.ignore(
		%i[mismatched_indentations unused_var],
		"#{Gem.loaded_specs['oga'].full_gem_path}/lib/oga/#{lexer_type}/lexer.rb"
	)
end

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
