# frozen_string_literal: true

module StreamTimer
	module Site
		## Controller for timer page
		class TimerController < Site::Controller
			def index(key)
				find_form_outcome = Forms::Timer::Find.new(key:).run

				# binding.pry

				if find_form_outcome.success? && (timer = find_form_outcome.result)
					view :index, scope: transform_to_view_object(timer)
				else
					halt 404
				end
			end
		end
	end
end
