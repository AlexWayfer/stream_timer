# frozen_string_literal: true

module StreamTimer
	module Site
		module Public
			## Controller for configurations management
			class ConfigurationsController < Site::Public::Controller
				include ST::ConfigurationsHelper

				def index
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
						update_user_session configuration_form_outcome: form_outcome

						redirect :edit, key: form_outcome.result.key, notice: t.notice.configuration.created
					else
						view_validation_errors :new, form_outcome
					end
				end

				def edit(key)
					initialize_configuration_update_form key

					@subtitle = @form.name

					view
				end

				def update(key)
					initialize_configuration_update_form key

					if (form_outcome = @form.run).success?
						update_user_session configuration_form_outcome: form_outcome

						redirect :edit, key: key, notice: t.notice.configuration.updated
					else
						view_validation_errors :edit, form_outcome
					end
				end

				post def load
					halt_unless_user_found_by_given_key

					update_user_session user: @found

					redirect :index, notice: t.notice.user.loaded
				end

				protected

				def execute(action)
					if %i[edit update].include?(action) && !current_user
						halt redirect :index, error: t.error.user.not_found.by_key_from_cookies
					end

					super
				end

				private

				def halt_unless_user_found_by_given_key
					return if (@found = find_user params[:user_key])

					halt redirect path_to_back, error: t.error.user.not_found.by_given_key
				end
			end
		end
	end
end
