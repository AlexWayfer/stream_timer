# frozen_string_literal: true

module StreamTimer
	module Site
		module Public
			module Auth
				## Twitch Auth callbacks
				class TwitchController < Auth::Controller
					def callback
						form = Forms::Twitch::Connect.new(auth_hash:, current_user:)

						if (form_outcome = form.run).success?
							update_user_session user: form.current_user

							redirect ConfigurationsController, notice: t.notice.twitch.connected
						else
							redirect ConfigurationsController, error: form_outcome.errors.translations
						end
					end
				end
			end
		end
	end
end
