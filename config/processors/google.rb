# frozen_string_literal: true

require 'google/apis/people_v1'

module StreamTimer
	module Config
		module Processors
			## Initialize Google API client
			class Google
				def initialize(config)
					## I'd like to use simpler method:
					## https://github.com/googleapis/google-auth-library-ruby/issues/358
					authorizer = ::Google::Auth::ServiceAccountCredentials.make_creds(
						json_key_io: File.open("#{config[:config_dir]}/google_service_account_json_key.json"),
						scope: ['https://www.googleapis.com/auth/userinfo.profile']
					)
					authorizer.fetch_access_token!

					client = ::Google::Apis::PeopleV1::PeopleServiceService.new
					client.authorization = authorizer

					config[:google][:client] = client
				end
			end
		end
	end
end
