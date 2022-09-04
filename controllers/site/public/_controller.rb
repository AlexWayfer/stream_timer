# frozen_string_literal: true

module StreamTimer
	module Site
		module Public
			## Base controller for public part of site
			class Controller < ST::Site::Controller
				include Flame::Flash
				include Flame::Menu

				include ST::UsersHelper

				MENU_ITEMS = %i[
					about
					configurations
				].freeze

				protected

				def available?(_controller = self.class)
					true
				end

				private

				def render_external_link(text, href)
					render(:_external_link, text:, href:).chomp
				end
			end
		end
	end
end
