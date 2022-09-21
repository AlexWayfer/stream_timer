# frozen_string_literal: true

module StreamTimer
	module Site
		module Public
			## Controller for disconnecting from third-party providers
			class DisconnectController < Site::Public::Controller
				post def twitch
					current_user.twitch_user.destroy

					redirect ConfigurationsController, notice: t.notice.twitch.disconnected
				end
			end
		end
	end
end
