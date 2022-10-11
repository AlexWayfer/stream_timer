# frozen_string_literal: true

Sequel.migration do
	change do
		%i[twitch_users google_users].each do |table_name|
			alter_table table_name do
				add_column :created_at, :timestamptz, null: false, default: Sequel::CURRENT_TIMESTAMP
				add_column :updated_at, :timestamptz
			end
		end
	end
end
