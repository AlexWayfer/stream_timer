# frozen_string_literal: true

require 'twitch-api'

module StreamTimer
	module Config
		module Processors
			## Initialize Twitch API client
			class Twitch
				def initialize(config)
					config[:twitch][:tokens] = ::TwitchOAuth2::Tokens.new(
						client: {
							client_id: config[:twitch][:client_id],
							client_secret: config[:twitch][:client_secret]
						}
					)

					config[:twitch][:client] = ::Twitch::Client.new(
						tokens: config[:twitch][:tokens]
					)
				end
			end
		end
	end
end
