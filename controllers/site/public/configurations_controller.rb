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

				def delete(key)
					## For `view_validation_errors`
					initialize_configuration_update_form key

					form_outcome = Forms::Configuration::Delete.run(@form.instance)

					if form_outcome.success?
						redirect :index, notice: t.notice.configuration.deleted
					else
						view_validation_errors :edit, form_outcome
					end
				end

				protected

				def execute(action)
					if %i[edit update delete].include?(action) && !current_user
						halt redirect :index, error: t.error.user.not_found.by_key_from_cookies
					end

					super
				end
			end
		end
	end
end
