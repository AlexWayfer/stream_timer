# frozen_string_literal: true

module StreamTimer
	module Forms
		module User
			## Form for User key regeneration
			class RegenerateKey < Forms::Model::Update
				field :key

				def initialize(pf_or_instance)
					super({ key: Sequel.function(:gen_random_uuid) }, pf_or_instance)
				end

				private

				def execute
					super

					instance.refresh
				end
			end
		end
	end
end
