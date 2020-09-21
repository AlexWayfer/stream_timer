# frozen_string_literal: true

require 'memery'
require 'r18n-core/helpers'

require_relative 'mail/_base'

module StreamTimer
	## Module for mailers
	module Mailers
		## Base class for sending mails
		class Base
			INTERVAL = 0.5

			include ::R18n::Helpers
			include Memery

			using GorillaPatch::Inflections

			def initialize(**args)
				@from = ST::Application.config[:mail][:from]
				@args = args
				@mails = []

				original_locale = R18n.get
				add_mails
				R18n.thread_set original_locale
			end

			def send!
				File.write lock_file, ''
				Thread.new do
					send_mails
				ensure
					File.delete lock_file
				end
			end

			private

			memoize def path_parts
				self.class.name.underscore.split('/').drop(2)
			end

			def add_mail(type, account, **view_args)
				return if ENV['RACK_ENV'] == 'test'

				@controller = ST::MailController.new
				@controller.recipient = account
				@controller.path_parts = [*path_parts, type.to_s]
				body = @controller.render_mail @args.merge(view_args)
				@mails << initialize_mail(account, body)
			end

			def initialize_mail(account, body)
				Mailers::Mail.activated.new(
					from: @from,
					to: account.email,
					subject: @controller.mail_subject,
					body: body
				)
			end

			def send_mails
				@mails.each.with_index(1) do |mail, index|
					ST::Application.logger.info "#{mail.log_message} [#{index}/#{count}]..."
					mail.send!
					sleep INTERVAL
				end
			end

			memoize def lock_file
				File.join(ST::Application.config[:tmp_dir], "mailing_#{object_id}")
			end

			memoize def count
				@mails.count
			end
		end
	end
end
