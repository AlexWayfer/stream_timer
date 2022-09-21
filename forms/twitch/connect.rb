# frozen_string_literal: true

module StreamTimer
	module Forms
		module Twitch
			## Form for Twitch connection
			class Connect < Forms::Base
				field :auth_hash, Hash
				nested :current_user, Forms::User::FindOrCreate

				def execute
					@twitch_user.update(info: auth_hash['info'], user: current_user)
				end

				private

				def validate
					super

					return unless validate_provision :auth_hash

					@twitch_user = Models::TwitchUser.find_or_new(uid: auth_hash['uid'])

					## There is no `self.current_user = ` method, also `FindOrCreate#instance` is complicated.
					current_user_form.find_form.user ||= @twitch_user.user

					## It runs nested form (and create User if neccessary)
					validate_provision :current_user
				end
			end
		end
	end
end
