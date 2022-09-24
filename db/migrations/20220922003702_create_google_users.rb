# frozen_string_literal: true

Sequel.migration do
	change do
		create_table :google_users do
			primary_key :id

			foreign_key :user_id, :users, null: false, unique: true

			column :uid, String, null: false, unique: true
			column :info, :jsonb, null: false
		end
	end
end
