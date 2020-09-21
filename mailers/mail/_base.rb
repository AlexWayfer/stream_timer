# frozen_string_literal: true

module StreamTimer
	module Mailers
		## Module for mail objects
		module Mail
			class << self
				attr_accessor :activated
			end

			## Base class for generating emails
			class Base
				# def initialize(from:, to:, subject:, body:); end

				def send!
					Retries.run(
						max_tries: 5, base_sleep_seconds: 1, max_sleep_seconds: 30
					) do
						sending_behavior
					end
				rescue StandardError => e
					ST::Application.logger.error e
					Raven.capture_exception(
						e, logger: :email, extra: { failed_recipient: to }
					)
				end

				def log_message
					"Sending email '#{subject}' to #{to}"
				end

				private

				def subject
					@mail.subject
				end

				def to
					@mail.to
				end

				def sending_behavior
					raise 'Sending behavior should be defined'
				end
			end
		end
	end
end
