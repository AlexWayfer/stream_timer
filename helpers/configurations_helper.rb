# frozen_string_literal: true

module StreamTimer
	## Helper for actions with configurations
	module ConfigurationsHelper
		include Memery

		private

		memoize def configuration_params
			params.fetch(:configuration, {}).merge(
				user: { key: current_user&.key }
			)
		end

		def initialize_configuration_create_form
			@form = Forms::Configuration::Create.new(configuration_params)
		end

		def initialize_configuration_update_form(configuration_key)
			initialize_configuration_find_form_outcome configuration_key

			halt 404, view(:not_found) unless (found = @find_form_outcome.result)

			@form = Forms::Configuration::Update.new(configuration_params, found)
		end

		memoize def current_user
			find_user cookies[:user_key]
		end

		def find_user(user_key)
			form_outcome = Forms::User::Find.new(key: user_key).run
			form_outcome.result if form_outcome.success?
		end

		def initialize_configuration_find_form_outcome(configuration_key)
			@find_form_outcome = Forms::Configuration::Find.new(configuration_key: configuration_key).run
		end

		def update_user_key_cookie(configuration_form_outcome)
			cookies[:user_key] = {
				value: configuration_form_outcome.result.user.key,
				path: '/',
				max_age: 365 * 24 * 60 * 60
			}
		end
	end
end
