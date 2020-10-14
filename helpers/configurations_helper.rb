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

		def initialize_configuration_update_form(key)
			found_configuration = find_configuration key

			halt 404, view(:not_found) unless found_configuration

			halt 403, view(:forbidden) unless current_user.pk_equal? found_configuration.user

			@form = Forms::Configuration::Update.new(configuration_params, found_configuration)
		end

		memoize def current_user
			find_user session[:user_key]
		end

		def find_user(user_key)
			form_outcome = Forms::User::Find.new(key: user_key).run
			form_outcome.result if form_outcome.success?
		end

		def find_configuration(key)
			form_outcome = Forms::Configuration::Find.new(key: key).run
			form_outcome.result if form_outcome.success?
		end

		def update_user_session(
			configuration_form_outcome: nil, user: configuration_form_outcome.result.user
		)
			session[:user_key] = user.key
		end
	end
end
