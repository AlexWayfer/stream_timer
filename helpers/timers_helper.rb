# frozen_string_literal: true

module StreamTimer
	## Helper for actions with timers
	module TimersHelper
		include Memery

		private

		memoize def timers_params
			params.fetch(:timer, {}).merge(
				user: { key: current_user&.key }
			)
		end

		def initialize_timer_create_form
			@form = Forms::Timer::Create.new(timers_params)
		end

		def initialize_timer_update_form(key)
			found_timer = find_timer key

			@form = Forms::Timer::Update.new(timers_params, found_timer)
		end

		def find_timer(key)
			form_outcome = Forms::Timer::Find.new(key:).run

			found = form_outcome.result if form_outcome.success?

			halt 404, view(:not_found) unless found

			halt 403, view(:forbidden) unless current_user.pk_equal? found.user

			found
		end
	end
end
