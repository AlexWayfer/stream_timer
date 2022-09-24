# frozen_string_literal: true

module StreamTimer
	module Models
		## Model for Google authentications
		class GoogleUser < Sequel::Model
			## Associations

			many_to_one :user
		end
	end
end
