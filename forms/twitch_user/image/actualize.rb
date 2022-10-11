# frozen_string_literal: true

module StreamTimer
	module Forms
		module TwitchUser
			module Image
				## Service for Twitch User avatar actualization
				class Actualize < Forms::ProviderUser::Image::Actualize
					private

					def request_image_url
						ST::Application.config[:twitch][:client]
							.get_users(id: provider_user.uid).data.first
							.profile_image_url
					end
				end
			end
		end
	end
end
