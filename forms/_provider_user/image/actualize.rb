# frozen_string_literal: true

module StreamTimer
	module Forms
		module ProviderUser
			module Image
				## Base form for providers users image actualization
				class Actualize < Forms::Base
					field :provider_user, Object

					private

					def execute
						current_image_url = provider_user.info['image']

						response = Faraday.head current_image_url

						return current_image_url if response.success?

						new_image_url = request_image_url

						## User can be banned, just skip it then
						return current_image_url unless new_image_url

						provider_user.update(info: provider_user.info.merge('image' => new_image_url))

						new_image_url
					end

					def validate
						validate_provision :provider_user
					end
				end
			end
		end
	end
end
