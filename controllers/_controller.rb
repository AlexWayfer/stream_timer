# frozen_string_literal: true

module StreamTimer
	## Base controller for any others controllers
	class Controller < Flame::Controller
		include Flame::R18n::Initialization
		R18n::Filters.on(:named_variables)

		include ST::ViewObjectHelper

		protected

		def execute(action)
			@action = action
			super
		end

		def not_found
			Flame::SentryContext.new(:not_found, controller: self).capture_message unless request.bot?

			super
		end

		def server_error(exception)
			# if config[:environment] == 'production'
			# 	affected_account = nil # authenticated.account
			# 	Mailers::Error::Internal.new(exception, request, params, affected_account).send!
			# end

			Flame::SentryContext.new(:server, controller: self).capture_exception(exception)

			super
		end

		private

		def logger
			ST::Application.logger
		end

		def csrf_tag
			Rack::Csrf.tag(request.env)
		end

		def view_validation_errors(
			template, form_outcome = nil, errors: form_outcome.errors.translations, **
		)
			status 422
			view template, error: errors, **
		end
	end
end
