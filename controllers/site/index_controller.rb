# frozen_string_literal: true

module StreamTimer
	module Site
		## Index controller for example
		class IndexController < Site::Controller
			include ST::ConfigurationHelper

			def index
				initialize_find_form_outcome

				halt redirect ConfigurationController, :edit if @find_form_outcome.success?

				initialize_configuration_create_form

				view
			end
		end
	end
end
