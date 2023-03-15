# frozen_string_literal: true

module StreamTimer
	module Site
		module Public
			## Index controller
			class IndexController < Site::Public::Controller
				def index; end

				protected

				def execute(action)
					halt redirect TimersController if current_user

					super
				end
			end
		end
	end
end
