# frozen_string_literal: true

module StreamTimer
	## Helper for configuration actions
	module ConfigurationHelper
		private

		def configuration_params
			params[:configuration]
		end

		def initialize_configuration_create_form
			@form = Forms::Configuration::Create.new(configuration_params)
		end

		def initialize_configuration_update_form
			find_form_outcome =
				Forms::Configuration::Find.new(configuration_key: cookies[:configuration_key]).run

			unless find_form_outcome.success?
				halt redirect :new, error: t.error.configuration.not_found.by_key_from_cookies
			end

			@form = Forms::Configuration::Update.new(configuration_params, find_form_outcome.result)
		end
	end
end
