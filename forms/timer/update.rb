# frozen_string_literal: true

module StreamTimer
	module Forms
		module Timer
			## Form for timer updating
			class Update < Forms::Model::Update
				include Timer::Change

				primary_field :key, String, merge: false
			end
		end
	end
end
