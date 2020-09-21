# frozen_string_literal: true

require 'formalism/sequel_transactions'

require 'formalism/r18n_errors'
require 'formalism/r18n_errors/validation_helpers'

## Define base form and model forms via gem
module StreamTimer
	module Forms
		## Base class for forms
		class Base < Formalism::Form
			extend Forwardable
			def_delegators 'self.class', :instance_name

			include Memery
			include Formalism::SequelTransactions
			include Formalism::R18nErrors
			include Formalism::R18nErrors::ValidationHelpers

			class << self
				include Memery

				using GorillaPatch::Inflections

				memoize def instance_name
					name.split('::')[2].underscore.to_sym
				end
			end

			def initialize(params = {})
				@errors_key = instance_name
				@mailers = []

				super
			end

			def before_retry
				clear_memery_cache!

				@mailers.clear

				super
			end

			def send_mails!
				nested_forms.each_value(&__method__)

				@mailers.each(&:send!)
			end

			private

			def db_connection
				ST::Application.db_connection
			end

			def after_db_transaction_commit
				send_mails!
			end
		end
	end

	Formalism::ModelForms.define_for_project self
end
