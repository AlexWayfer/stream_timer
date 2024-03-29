# frozen_string_literal: true

module StreamTimer
	module Models
		## Model for user with multiple timers
		class User < Sequel::Model
			## Associations

			one_to_one :twitch_user
			one_to_one :google_user

			one_to_many :timers
		end
	end
end
