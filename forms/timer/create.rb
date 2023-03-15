# frozen_string_literal: true

require_relative '../user/find_or_create'

module StreamTimer
	module Forms
		module Timer
			## Form for timer creation
			class Create < Forms::Model::Create
				include Timer::Change

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
