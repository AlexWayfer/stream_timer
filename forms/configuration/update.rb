# frozen_string_literal: true

module StreamTimer
	module Forms
		module Configuration
			## Form for configuration update
			class Update < Forms::Model::Update
				include Configuration::Base
			end
		end
	end
end
