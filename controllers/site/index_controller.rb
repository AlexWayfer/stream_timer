# frozen_string_literal: true

module StreamTimer
	module Site
		## Index controller for example
		class IndexController < ST::Site::Controller
			def index
				initialize_configuration_create_form

				view
			end

			post def configure
				initialize_configuration_create_form

				return view if (form_output = @form.run).success?

				view error: form_output.errors.translations
			end

			private

			def configuration_params
				params[:configuration]
			end

			def initialize_configuration_create_form
				@form = Forms::Configuration::Create.new(configuration_params)
			end
		end
	end
end
