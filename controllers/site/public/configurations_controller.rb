# frozen_string_literal: true

module StreamTimer
	module Site
		module Public
			## Controller for configurations management
			class ConfigurationsController < Site::Public::Controller
				include ST::ConfigurationsHelper

				def index
					initialize_configuration_create_form

					## TODO: Render list of user's timers

					view
				end

				def new
					## TODO: Render list of user's timers

					initialize_configuration_create_form

					view
				end

				def create
					initialize_configuration_create_form

					if (form_outcome = @form.run).success?
						update_user_key_cookie form_outcome

						redirect :edit, configuration_key: form_outcome.result.configuration_key
					else
						view_validation_errors :new, form_outcome
					end
				end

				def edit(configuration_key)
					unless current_user
						halt redirect :index, error: t.error.user.not_found.by_key_from_cookies
					end

					initialize_configuration_update_form configuration_key

					@subtitle = @form.name

					view
				end

				def update(configuration_key)
					initialize_configuration_update_form configuration_key

					if (form_outcome = @form.run).success?
						update_user_key_cookie form_outcome

						redirect :edit, configuration_key: configuration_key
					else
						view_validation_errors :edit, form_outcome
					end
				end

				post def load
					found = find_user params[:user_key]

					halt redirect :index, error: t.error.user.not_found.by_given_key unless found

					cookies[:user_key] = found.key

					redirect :index
				end
			end
		end
	end
end
