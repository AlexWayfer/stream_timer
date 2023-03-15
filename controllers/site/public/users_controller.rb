# frozen_string_literal: true

module StreamTimer
	module Site
		module Public
			## Controller for users management
			class UsersController < Site::Public::Controller
				post def load
					halt_unless_user_found_by_given_key

					update_user_session user: @found

					redirect TimersController, :index, notice: t.notice.user.itself.loaded
				end

				post def regenerate_key
					halt_unless_user_found_by_key_from_cookies

					form_outcome = Forms::User::RegenerateKey.run(current_user)

					redirect path_to_back, **
						if form_outcome.success?
							update_user_session user: current_user

							{ notice: t.notice.user.key.regenerated }
						else
							{ error: form_outcome.errors.translations }
						end
				end

				private

				def halt_unless_user_found_by_given_key
					return if (@found = find_user params[:user_key])

					halt redirect path_to_back, error: t.error.user.not_found.by_given_key
				end

				def halt_unless_user_found_by_key_from_cookies
					return if current_user

					halt redirect path_to_back, error: t.error.user.not_found.by_key_from_cookies
				end
			end
		end
	end
end
