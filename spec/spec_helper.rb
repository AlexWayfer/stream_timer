# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'test'

require 'pry-byebug'

Dir["#{__dir__}/**/spec_helper.rb"].each do |spec_helper|
	next if spec_helper == __FILE__

	require spec_helper
end
