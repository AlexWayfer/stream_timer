# frozen_string_literal: true

module StreamTimer
	## View object controller stuff
	module ViewObjectHelper
		extend ::ModuleMethods::Extension

		## Module for controller class methods
		module ClassMethods
			include Memery

			using GorillaPatch::Namespace
			using GorillaPatch::Inflections.from_sequel

			memoize def view_object_class
				const_name = demodulize.delete_suffix('Controller').singularize

				return unless ViewObjects.const_defined?(const_name)

				ViewObjects.const_get(const_name)
			end
		end

		private

		def transform_to_view_object(object)
			self.class.view_object_class.then { |klass| klass.nil? ? object : klass.new(self, object) }
		end
	end
end
