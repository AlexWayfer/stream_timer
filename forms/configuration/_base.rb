# frozen_string_literal: true

module StreamTimer
	module Forms
		module Configuration
			## Common code for `Create` and `Update` forms
			module Base
				include Formalism::Form::Fields

				TIME_LIMITS = {
					hours: (0..).freeze,
					minutes: (0..59).freeze,
					seconds: (0..59).freeze
				}.freeze

				field :countdown_text_before, String, default: 'AFK '
				field :lateness_text_before, String, default: 'Late for '

				field :hours, Integer, default: 0
				field :minutes, Integer, default: 5
				field :seconds, Integer, default: 0

				field :background_color, String, default: 'white'
				field :background_opacity, BigDecimal, default: 0

				field :font_size, Integer, default: 160
				field :font_color, String, default: 'black'

				private

				def validate
					TIME_LIMITS.each do |time_component, limit|
						validate_range_entry time_component, limit
					end

					validate_max_length :countdown_text_before, 200
					validate_max_length :lateness_text_before, 200

					validate_entry %i[hours minutes seconds]

					validate_choice :background_color
					validate_range_entry :background_opacity, 0..1
					validate_entry :font_size
					validate_choice :font_color
				end
			end
		end
	end
end
