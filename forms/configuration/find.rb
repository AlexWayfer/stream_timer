# frozen_string_literal: true

module StreamTimer
	module Forms
		module Configuration
			## Form for configuration finding
			class Find < Forms::Model::Find
				primary_field :key, String, default: nil

				private

				def validate
					validate_uuid :key
				end
			end
		end
	end
end
