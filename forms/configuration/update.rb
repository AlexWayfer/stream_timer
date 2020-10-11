# frozen_string_literal: true

module StreamTimer
	module Forms
		module Configuration
			## Form for configuration update
			class Update < Forms::Model::Update
				include Configuration::Base

				PRIMARY_KEY = :configuration_key
			end
		end
	end
end
