# frozen_string_literal: true

module StreamTimer
	module Site
		## Controller for timer page
		class TimerController < Site::Controller
			include ST::ConfigurationsHelper

			def index(key)
				configuration = find_configuration key, check_user: false

				view :index, scope: transform_to_view_object(configuration)
			end

			def demo
				configuration = initialize_configuration_create_form.instance

				view :index, scope: transform_to_view_object(configuration)
			end

			private

			## For `configuration_params`
			def current_user
				nil
			end
		end
	end
end
