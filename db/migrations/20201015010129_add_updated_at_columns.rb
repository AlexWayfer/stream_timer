# frozen_string_literal: true

Sequel.migration do
	change do
		alter_table :users do
			add_column :updated_at, :timestamptz
		end

		alter_table :configurations do
			add_column :updated_at, :timestamptz
		end
	end
end
