# frozen_string_literal: true

config = ST::Application.config

class << config
	private

	def find_config_file(filename, required:)
		file_path = nil

		loop do
			file_path = super
			break
		rescue Flame::Errors::ConfigFileNotFoundError => e
			puts e.message

			next if ask_to_check_config_files

			required ? abort : break
		end

		file_path
	end

	def ask_to_check_config_files
		highline.choose do |menu|
			menu.layout = :one_line

			menu.prompt = 'Do you want to check config files? '

			menu.choice(:yes) do
				system 'toys config check'
				true
			end

			menu.choice(:no) { false }
		end
	end

	def highline
		@highline ||= begin
			require 'highline'
			HighLine.new
		end
	end
end

GorillaPatch::Inflections.acronyms.add 'OmniAuth'

using GorillaPatch::Inflections

config.instance_exec do
	self[:root_dir] = File.realpath "#{__dir__}/.."

	self[:pids_dir] = "#{self[:tmp_dir]}/pids"

	self[:stdout_file] = "#{self[:log_dir]}/out"
	self[:stderr_file] = "#{self[:log_dir]}/err"

	%i[session site twitch google].each do |config_name|
		load_yaml config_name, required: true
	end

	%w[Server Sentry R18n Mail Sequel Shrine OmniAuth].each do |processor_name|
		require_relative "processors/#{processor_name.underscore}"
		ST::Config::Processors.const_get(processor_name).new self
	end
end
