# frozen_string_literal: true

module StreamTimer
	module Models
		## Model for a single time configuration
		class Configuration < Sequel::Model
			## Associations

			many_to_one :user
		end
	end
end
