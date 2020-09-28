# frozen_string_literal: true

module StreamTimer
	module Site
		## Base controller for site-section
		class Controller < ST::Controller
			include Flame::Flash

			protected

			def execute(method)
				response.headers[Rack::CONTENT_TYPE] = 'text/html; charset=UTF-8'
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

			private

			def highlighted_backtrace_for(exception)
				root_dir = config[:root_dir]
				lines = exception.backtrace.map do |line|
					line[root_dir] ? "#{root_dir}<b>#{line.split(root_dir).last}</b>" : line
				end
				lines.join($RS)
			end
		end
	end
end
