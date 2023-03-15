# frozen_string_literal: true

module StreamTimer
	module Site
		module Public
			## Controller for timers management
			class TimersController < Site::Public::Controller
				include ST::TimersHelper

				def index
					initialize_timer_create_form

					view
				end

				def new
					initialize_timer_create_form

					view
				end

				def create
					initialize_timer_create_form

					if (form_outcome = @form.run).success?
						update_user_session user: form_outcome.result.user

						redirect :edit, key: form_outcome.result.key, notice: t.notice.timer.created
					else
						view_validation_errors :new, form_outcome
					end
				end

				def edit(key)
					initialize_timer_update_form key

					@subtitle = @form.name

					view
				end

				def update(key)
					initialize_timer_update_form key

					if (form_outcome = @form.run).success?
						update_user_session user: form_outcome.result.user

						redirect :edit, key:, notice: t.notice.timer.updated
					else
						view_validation_errors :edit, form_outcome
					end
				end

				def delete(key)
					## For `view_validation_errors`
					initialize_timer_update_form key

					form_outcome = Forms::Timer::Delete.run(@form.instance)

					if form_outcome.success?
						redirect :index, notice: t.notice.timer.deleted
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

				private

				using GorillaPatch::Inflections

				def connection_image_url(provider_name, provider_user)
					Forms.const_get("#{provider_name.to_s.camelize}User", false)::Image::Actualize
						.run(provider_user:).result
				end
			end
		end
	end
end
