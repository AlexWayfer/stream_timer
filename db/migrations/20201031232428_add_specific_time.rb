# frozen_string_literal: true

Sequel.migration do
	change do
		alter_table :configurations do
			add_column :specific_time, :timestamp, null: true, default: nil
		end
	end
end
