# frozen_string_literal: true

require_relative '../user/find_or_create'

module StreamTimer
	module Forms
		module Configuration
			## Form for configuration creation
			class Create < Forms::Model::Create
				include Configuration::Base

				nested :user, Forms::User::FindOrCreate

				private

				def validate
					super

					validate_provision :user
				end
			end
		end
	end
end
