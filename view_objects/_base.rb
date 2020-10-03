# frozen_string_literal: true

module StreamTimer
	module ViewObjects
		## Base class for view objects
		class Base
			extend Forwardable

			def_delegators :@controller, :config, :request, :flash, :path_to, :url_to

			def initialize(controller)
				@controller = controller
			end
		end
	end
end
