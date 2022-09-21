# frozen_string_literal: true

module StreamTimer
	module Models
		## Model for Twitch authentications
		class TwitchUser < Sequel::Model
			## Associations

			many_to_one :user
		end
	end
end
