# frozen_string_literal: true

## Require dirs
ST::Application.require_dirs ST::APP_DIRS, ignore: [%r{config/puma.rb}, %r{lib/\w+/spec/}]

ST::Application.class_exec do
	## Site
	mount :site, '/'
end
