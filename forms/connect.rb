# frozen_string_literal: true

module StreamTimer
	module Forms
		## Form for OmniAuth connections
		class Connect < Forms::Base
			field :auth_hash, Hash
			field :provider_user_model_class, Class
			nested :current_user, Forms::User::FindOrCreate

			def execute
				@provider_user.update(info: auth_hash['info'], user: current_user)
			end

			private

			def validate
				super

				return unless validate_provision :auth_hash, :provider_user_model_class

				@provider_user = provider_user_model_class.find_or_new(uid: auth_hash['uid'])

				## There is no `self.current_user = ` method, also `FindOrCreate#instance` is complicated.
				current_user_form.find_form.user ||= @provider_user.user

				## It runs nested form (and create User if neccessary)
				validate_provision :current_user
			end
		end
	end
end
