# frozen_string_literal: true

module StreamTimer
	module Forms
		module Timer
			## Common code for `Create` and `Update` forms
			module Change
				include Formalism::Form::Fields

				TIME_LIMITS = {
					hours: (0..),
					minutes: (0..59),
					seconds: (0..59)
				}.freeze

				DEFAULT_TEXTS = {
					countdown: {
						name: 'AFK timer',
						countdown_text_before: 'AFK ',
						countup_text_before: 'Late for '
					}.freeze,
					only_countup: {
						name: 'Uptime timer',
						countup_text_before: 'Uptime '
					}.freeze
				}.freeze

				field :name, String,
					default: -> { DEFAULT_TEXTS[only_countup ? :only_countup : :countdown][:name] }

				field :only_countup, :boolean, default: false
				field :display_countdown_information, :boolean, default: false
				field :display_countup_time, :boolean, default: true

				field :countdown_text_before, String,
					default: DEFAULT_TEXTS[:countdown][:countdown_text_before]

				field :countup_text_before, String,
					default: (lambda do
						DEFAULT_TEXTS[only_countup ? :only_countup : :countdown][:countup_text_before]
					end)

				field :specific_time, default: nil

				field :hours, Integer, default: 0
				field :minutes, Integer, default: 5
				field :seconds, Integer, default: 0

				field :background_color, String, default: '#000000'
				field :background_opacity, BigDecimal, default: 0.75

				field :font_size, Integer, default: 160
				field :font_color, String, default: '#ffffff'

				def specific_time=(value)
					value = nil if value&.empty?
					super value
				end

				private

				def validate
					validate_entry :name

					validate_max_length :countdown_text_before, 200
					validate_max_length :countup_text_before, 200

					validate_time

					validate_choice :background_color
					validate_range_entry :background_opacity, 0..1
					validate_entry :font_size
					validate_choice :font_color
				end

				def validate_time
					TIME_LIMITS.each do |time_component, limit|
						validate_range_entry time_component, limit
					end

					validate_entry %i[hours minutes seconds]
				end
			end
		end
	end
end
