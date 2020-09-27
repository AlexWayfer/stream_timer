# frozen_string_literal: true

module Flame
	## Patch for `Flame::RavenContext` with `#user` definition
	class RavenContext
		private

		def user
			# @controller&.send(:authenticated)&.account
		end
	end
end
