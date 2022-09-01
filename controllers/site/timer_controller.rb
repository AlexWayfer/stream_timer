# frozen_string_literal: true

module StreamTimer
	module Site
		## Controller for timer page
		class TimerController < Site::Controller
			def index(key)
				find_form_outcome = Forms::Configuration::Find.new(key:).run

				if find_form_outcome.success? && (configuration = find_form_outcome.result)
					view :index, scope: transform_to_view_object(configuration)
				else
					halt 404
				end
			end
		end
	end
end
