# frozen_string_literal: true

Sequel.migration do
	change do
		alter_table :configurations do
			add_column :display_countdown_information, TrueClass, null: false, default: false
		end
	end
end
