# frozen_string_literal: true

module StreamTimer
	module Forms
		module TwitchUser
			module Image
				## Service for Twitch User avatar actualization
				class Actualize < Forms::ProviderUser::Image::Actualize
					private

					def request_image_url
						found_user =
							ST::Application.config[:twitch][:client]
								.get_users(id: provider_user.uid).data.first

						## User can be banned
						return unless found_user

						found_user.profile_image_url
					end
				end
			end
		end
	end
end
