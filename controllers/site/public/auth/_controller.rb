# frozen_string_literal: true

module StreamTimer
	module Site
		module Public
			module Auth
				## Base controller for OmniAuth
				class Controller < Site::Public::Controller
					private

					def auth_hash
						request.env['omniauth.auth']
					end
				end
			end
		end
	end
end
