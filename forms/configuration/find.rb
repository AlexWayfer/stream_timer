# frozen_string_literal: true

module StreamTimer
	module Forms
		module Configuration
			## Form for configuration finding
			class Find < Forms::Model::Find
				remove_field :id

				field :configuration_key, String
				field :timer_key, String

				private

				def validate
					validate_uuid :configuration_key if configuration_key
					validate_uuid :timer_key if timer_key
				end
			end
		end
	end
end
