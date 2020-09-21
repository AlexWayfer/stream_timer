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
			subject { Oga.parse_html super().body }

			describe '<title>' do
				subject { super().css('title').text }

				it { is_expected.to eq 'Stream Timer' }
			end

			describe '<body>' do
				subject { super().css('body').first }

				describe 'project title' do
					subject { super().css('> h1').first.text }

					it { is_expected.to eq 'Stream Timer' }
				end
			end
		end
	end
end
