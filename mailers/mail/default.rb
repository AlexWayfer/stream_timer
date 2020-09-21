# frozen_string_literal: true

module StreamTimer
	module Mailers
		module Mail
			## Class for generating emails by `mail` gem
			class Default < Mail::Base
				def initialize(from:, to:, subject:, body:)
					super
					@mail = ::Mail.new do
						from "#{from[:name]} <#{from[:email]}>"
						to to
						subject subject
						html_part do
							content_type 'text/html; charset=UTF-8'
							body body
						end
					end
				end

				private

				def sending_behavior
					@mail.deliver!
				end
			end
		end
	end
end
