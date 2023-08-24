# frozen_string_literal: true

module StreamTimer
	module ViewObjects
		## Base class for view objects
		class Base
			extend Forwardable

			def_delegators :@controller, :config, :request, :flash, :path_to, :url_to, :current_user

			def initialize(controller)
				@controller = controller
			end

			private

			def render(*, **)
				@controller.send(__method__, *, **, scope: self)
			end
		end
	end
end
