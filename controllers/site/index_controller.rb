# frozen_string_literal: true

module StreamTimer
	module Site
		## Index controller
		class IndexController < Site::Controller
			def index
				redirect Public::IndexController
			end
		end
	end
end
