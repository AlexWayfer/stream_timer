# frozen_string_literal: true

module StreamTimer
	module Forms
		module Configuration
			## Form for configuration updating
			class Update < Forms::Model::Update
				include Configuration::Change

				primary_field :key, String, merge: false
			end
		end
	end
end
