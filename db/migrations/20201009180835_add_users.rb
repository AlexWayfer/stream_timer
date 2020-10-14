# frozen_string_literal: true

Sequel.migration do
	change do
		create_table :users do
			primary_key :id

			column :key, :uuid, null: false, default: Sequel.function(:gen_random_uuid)

			column :created_at, :timestamptz, null: false, default: Sequel::CURRENT_TIMESTAMP
		end

		self[:configurations].delete

		alter_table :configurations do
			add_foreign_key :user_id, :users, null: false, on_delete: :cascade

			drop_column :configuration_key
			rename_column :timer_key, :key

			add_column :name, String, null: false
		end
	end
end
