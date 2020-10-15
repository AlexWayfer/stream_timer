# frozen_string_literal: true

module StreamTimer
	## Helper for interactions with users
	module UsersHelper
		include Memery

		private

		memoize def current_user
			find_user session[:user_key]
		end

		def find_user(user_key)
			form_outcome = Forms::User::Find.new(key: user_key).run
			form_outcome.result if form_outcome.success?
		end

		def update_user_session(
			configuration_form_outcome: nil, user: configuration_form_outcome.result.user
		)
			session[:user_key] = user.key
		end
	end
end
