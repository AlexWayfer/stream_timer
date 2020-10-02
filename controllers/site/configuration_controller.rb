# frozen_string_literal: true

module StreamTimer
	module Site
		## Controller for configuration management
		class ConfigurationController < Site::Controller
			include ST::ConfigurationHelper

			def index
				initialize_configuration_find_form_outcome

				halt redirect :edit if @find_form_outcome.result

				initialize_configuration_create_form

				view
			end

			def new
				initialize_configuration_create_form

				view
			end

			def create
				initialize_configuration_create_form

				if (form_outcome = @form.run).success?
					cookies[:configuration_key] = form_outcome.result.configuration_key

					redirect :edit
				else
					view_validation_errors :new, form_outcome
				end
			end

			def edit
				initialize_configuration_update_form

				view
			end

			def update
				initialize_configuration_update_form

				if (form_outcome = @form.run).success?
					redirect :edit
				else
					view_validation_errors :edit, form_outcome
				end
			end

			post def load
				initialize_configuration_find_form_outcome configuration_params

				unless @find_form_outcome.success?
					halt redirect :new, error: t.error.configuration.not_found.by_given_key
				end

				cookies[:configuration_key] = @find_form_outcome.result.configuration_key

				redirect :edit
			end
		end
	end
end
