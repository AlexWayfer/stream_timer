# frozen_string_literal: true

module StreamTimer
	module Models
		## Model for a single time timer
		class Timer < Sequel::Model
			## Associations

			many_to_one :user
		end
	end
end
