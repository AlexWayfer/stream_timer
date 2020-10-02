# frozen_string_literal: true

module StreamTimer
	module Site
		## Index controller for example
		class IndexController < Site::Controller
			def index
				redirect ConfigurationController
			end
		end
	end
end
