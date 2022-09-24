# frozen_string_literal: true

module StreamTimer
	module Site
		module Public
			## Controller for OmniAuth callbacks
			class AuthController < Site::Public::Controller
				CONNECT_PROVIDERS.each do |provider|
					get "/#{provider[:path]}/callback", (
						define_method("#{provider[:name]}_callback") do
							initialize_connect_form(provider[:name])

							if (form_outcome = @form.run).success?
								update_user_session user: @form.current_user

								redirect ConfigurationsController, notice: t.notice[provider[:name]].connected
							else
								redirect ConfigurationsController, error: form_outcome.errors.translations
							end
						end
					)
				end

				private

				using GorillaPatch::Inflections

				memoize def initialize_connect_form(provider_name)
					@form = Forms::Connect.new(
						## Not a constant because `Sequel::Model` has no method `dup`,
						## and there is `params.deep_dup` in Form initialization.
						provider_user_model_class: "ST::Models::#{provider_name.to_s.camelize}User",
						auth_hash:,
						current_user:
					)
				end

				def auth_hash
					request.env['omniauth.auth']
				end
			end
		end
	end
end
