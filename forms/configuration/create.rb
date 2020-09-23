# frozen_string_literal: true

module StreamTimer
	module Forms
		module Configuration
			## Form for configuration creation
			class Create < Forms::Model::Create
				include Configuration::Base
			end
		end
	end
end
