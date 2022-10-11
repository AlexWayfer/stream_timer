# frozen_string_literal: true

module StreamTimer
	module Forms
		module GoogleUser
			module Image
				## Service for Google User avatar actualization
				class Actualize < Forms::ProviderUser::Image::Actualize
					private

					def request_image_url
						ST::Application.config[:google][:client]
							.get_person("people/#{provider_user.uid}", person_fields: 'photos')
							.photos.first.url
					end
				end
			end
		end
	end
end
