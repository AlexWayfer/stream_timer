# frozen_string_literal: true

module StreamTimer
	module Forms
		module Configuration
			## Form for configuration deleting
			class Delete < Forms::Model::Delete
				primary_field :key, String
			end
		end
	end
end
