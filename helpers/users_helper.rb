# frozen_string_literal: true

module StreamTimer
	## Helper for interactions with users
	module UsersHelper
		include Memery

		## TODO: Think about `Authenticated`
		memoize def current_user
			find_user session[:user_key]
		end

		private

		def find_user(user_key)
			form_outcome = Forms::User::Find.new(key: user_key).run
			form_outcome.result if form_outcome.success?
		end

		def update_user_session(user: nil, user_key: user.key)
			session[:user_key] = user_key
		end
	end
end
