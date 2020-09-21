# frozen_string_literal: true

module Flame
	## Define and include patch
	class RavenContext
		## Patch for `Flame::RavenContext` with `#user` definition
		module Patch
			private

			def user
				# @controller&.send(:authenticated)&.account
			end
		end

		include Patch
	end
end
