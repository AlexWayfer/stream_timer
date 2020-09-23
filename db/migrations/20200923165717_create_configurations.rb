# frozen_string_literal: true

Sequel.migration do
	change do
		create_table :configurations do
			primary_key :id

			column :configuration_key, :uuid, null: false, default: Sequel.function(:gen_random_uuid)
			column :timer_key, :uuid, null: false, default: Sequel.function(:gen_random_uuid)

			column :hours, Integer, null: false
			column :minutes, Integer, null: false
			column :seconds, Integer, null: false

			column :countdown_text_before, String
			column :lateness_text_before, String

			column :background_color, String, null: false
			column :background_opacity, BigDecimal, size: [3, 2], null: false

			column :font_size, Integer, null: false
			column :font_color, String, null: false

			column :created_at, :timestamptz, null: false, default: Sequel::CURRENT_TIMESTAMP
		end
	end
end
