# frozen_string_literal: true

module StreamTimer
	module Site
		## Index controller for example
		class IndexController < Site::Controller
			include ST::ConfigurationHelper

			def index
				initialize_configuration_create_form

				view
			end
		end
	end
end
