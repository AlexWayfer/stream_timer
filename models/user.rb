# frozen_string_literal: true

module StreamTimer
	module Models
		## Model for user with multiple configurations
		class User < Sequel::Model
			## Associations

			one_to_many :configurations
		end
	end
end
