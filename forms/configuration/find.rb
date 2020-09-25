# frozen_string_literal: true

module StreamTimer
	module Forms
		module Configuration
			## Form for configuration finding
			class Find < Forms::Model::Find
				remove_field :id

				field :configuration_key, String

				private

				def validate
					return true if UUID.validate :configuration_key

					add_error :configuration_key, :not_valid_uuid
				end
			end
		end
	end
end
