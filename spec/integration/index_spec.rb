# frozen_string_literal: true

describe '/' do
	include_context 'with Rack Test'

	before do
		get '/'
	end

	describe 'response' do
		subject { last_response }

		it { is_expected.to be_ok }

		describe 'body' do
			subject { super().body }

			it { is_expected.to include 'Hello, world!' }
		end
	end
end
