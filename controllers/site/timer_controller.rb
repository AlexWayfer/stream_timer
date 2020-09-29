# frozen_string_literal: true

module StreamTimer
	module Site
		## Controller for timer page
		class TimerController < Site::Controller
			include ST::ConfigurationHelper

			def index(key)
				initialize_configuration_find_form_outcome timer_key: key

				if @find_form_outcome.success?
					view :index, scope: transform_to_view_object(@find_form_outcome.result)
				else
					halt 404
				end
			end
		end
	end
end
