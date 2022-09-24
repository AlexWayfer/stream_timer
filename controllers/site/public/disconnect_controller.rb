# frozen_string_literal: true

module StreamTimer
	module Site
		module Public
			## Controller for disconnecting from third-party providers
			class DisconnectController < Site::Public::Controller
				CONNECT_PROVIDERS.each do |provider|
					post(
						define_method(provider[:name]) do
							current_user.public_send("#{provider[:name]}_user").destroy

							redirect ConfigurationsController, notice: t.notice[provider[:name]].disconnected
						end
					)
				end
			end
		end
	end
end
