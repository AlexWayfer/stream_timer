# frozen_string_literal: true

require 'mail'

require_relative '../../mailers/_base'

module StreamTimer
	module Config
		module Processors
			## Configuration for mails
			class Mail
				def initialize(config)
					@config = config

					## Threads (for mails)
					Thread.abort_on_exception = true

					@mail_config = @config.load_yaml :mail
					return unless @mail_config

					@config[:mails_dir] = proc { File.join self[:views_dir], 'mails' }

					validate_site_url

					configure_appropriate_provider
				end

				private

				def configure_appropriate_provider
					if @mail_config[:send_grid]
						configure_send_grid
					elsif @mail_config[:smtp]
						configure_smtp
					elsif @config[:environment] != 'test'
						configure_letter_opener
					end
				end

				def configure_send_grid
					require_relative '../../mailers/mail/send_grid'

					Mailers::Mail.activated = Mailers::Mail::SendGrid

					Mailers::Mail::SendGrid.client = SendGrid::API.new(
						api_key: @mail_config[:send_grid][:api_key],
						host: 'https://api.sendgrid.com'
					).client
				end

				def configure_smtp
					activate_default_mail

					smtp_config = @mail_config[:smtp]

					::Mail.defaults do
						delivery_method :smtp, smtp_config if smtp_config
					end
				end

				def configure_letter_opener
					require 'letter_opener'

					activate_default_mail

					letter_opener_dir = File.join @config[:tmp_dir], 'letter_opener'

					::Mail.defaults do
						delivery_method LetterOpener::DeliveryMethod, location: letter_opener_dir
					end
				end

				def activate_default_mail
					require_relative '../../mailers/mail/default'

					Mailers::Mail.activated = Mailers::Mail::Default
				end

				def validate_site_url
					site_url = @mail_config[:site_url]

					unless Rack::Request::DEFAULT_PORTS.key?(site_url[:scheme])
						raise 'Incorrect scheme of site URL in mail config'
					end

					return if site_url[:host]

					raise 'Host of site URL in mail config is required'
				end
			end
		end
	end
end
