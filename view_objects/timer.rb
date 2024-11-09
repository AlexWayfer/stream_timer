# frozen_string_literal: true

module StreamTimer
	module ViewObjects
		## View object for timer page
		class Timer < Base
			def_delegators(
				:@model,
				:only_countup, :display_countdown_information, :display_countup_time,
				:specific_time, :countdown_text_before, :countup_text_before, :hours
			)

			def initialize(controller, model)
				super(controller)

				@model = model
			end

			private

			def styles
				{
					'background-color' => background_color_with_opacity,
					'font-size' => "#{@model.font_size}px",
					'color' => @model.font_color
				}.map { |key, value| "#{key}: #{value};" }.join(' ')
			end

			def background_color_with_opacity
				@model.background_color + (@model.background_opacity * 255).floor.to_s(16)
			end

			%i[hours minutes seconds].each do |time_component|
				define_method :"padded_#{time_component}" do
					@model.public_send(time_component).to_s.rjust(2, '0')
				end
			end
		end
	end
end
