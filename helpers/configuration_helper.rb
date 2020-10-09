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
			initialize_configuration_find_form_outcome

			unless @find_form_outcome.result
				cookies[:configuration_key] = nil

				halt redirect :new, error: t.error.configuration.not_found.by_key_from_cookies
			end

			@form = Forms::Configuration::Update.new(configuration_params, @find_form_outcome.result)
		end

		def initialize_configuration_find_form_outcome(
			form_params = { configuration_key: cookies[:configuration_key] }
		)
			@find_form_outcome = Forms::Configuration::Find.new(form_params).run
		end

		def update_configuration_key_cookie(form_outcome)
			cookies[:configuration_key] = {
				value: form_outcome.result.configuration_key,
				max_age: 365 * 24 * 60 * 60
			}
		end
	end
end
