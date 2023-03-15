# frozen_string_literal: true

Sequel.migration do
	change do
		rename_table :configurations, :timers
	end
end
