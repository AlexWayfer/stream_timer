# frozen_string_literal: true

module StreamTimer
	module Site
		## Base controller for site-section
		class Controller < ST::Controller
			include Flame::Flash

			protected

			def execute(method)
				response.headers[Rack::CONTENT_TYPE] = 'text/html; charset=utf-8'
				super
			end

			def server_error(exception)
				@exception = exception
				super
			end

			def default_body
				render "errors/#{status}"
			rescue Flame::Errors::TemplateNotFoundError
				"<h1>#{super}</h1>"
			end
		end
	end
end
