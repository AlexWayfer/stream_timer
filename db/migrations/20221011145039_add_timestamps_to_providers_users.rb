# frozen_string_literal: true

Sequel.migration do
	users_tables = %i[twitch_users google_users].freeze

	up do
		users_tables.each do |table_name|
			alter_table table_name do
				add_column :created_at, :timestamptz, null: false, default: Sequel::CURRENT_TIMESTAMP
				add_column :updated_at, :timestamptz
			end
		end
	end

	down do
		users_tables.each do |table_name|
			alter_table table_name do
				drop_column :created_at
				drop_column :updated_at
			end
		end
	end
end
