# frozen_string_literal: true

Sequel.migration do
	change do
		alter_table :configurations do
			add_column :display_countup_time, TrueClass, null: false, default: true
		end
	end
end
