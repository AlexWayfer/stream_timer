# frozen_string_literal: true

module StreamTimer
	module Site
		module Public
			## Base controller for public part of site
			class Controller < ST::Site::Controller
				include Flame::Flash
				include Flame::Menu

				MENU_ITEMS = %i[
					configurations
					about
				].freeze

				protected

				def available?(_controller = self.class)
					true
				end
			end
		end
	end
end
