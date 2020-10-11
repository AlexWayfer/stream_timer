# frozen_string_literal: true

module StreamTimer
	module Forms
		module User
			class FindOrCreate < Forms::Model::FindOrCreate
				## TODO: Check before commit
				## Redefine due to validations
				# nested :find, namespace::Find,
				# 	initialize: ->(form) { form.new(@params_or_instance) },
				# 	merge_errors: false
			end
		end
	end
end
