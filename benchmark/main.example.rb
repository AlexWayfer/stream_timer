# frozen_string_literal: true

require 'bundler/setup'
Bundler.setup :system

require 'pry-byebug'

require 'benchmark'
require 'benchmark/ips'
require 'benchmark/memory'


puts '```ruby'
puts File.read(__FILE__).gsub("\t", '  ')
puts '```'
puts
puts '### Output'
puts
puts '```'


require 'memery'
require 'gorilla_patch'
# require 'sequel'
# require 'shrine'
# require 'r18n-core'
# require 'money'
# require_relative 'config/config'


OPTIONS = { a: 1, b: 2, c: 3 }.freeze


def via_direct
  { a: 1, b: 2, c: 3 }
end

def via_constant
  OPTIONS
end


def test
  results = %i[
    via_direct
    via_constant
  ].each_with_object([]) do |method_name, array|
    array << (result = send method_name)
    puts "Result of #{method_name}:"
    pp result
    puts
  end
  uniq_size = results.uniq.size
  puts "Uniq results: #{uniq_size}"
  puts
  exit 1 if uniq_size > 1
end

test

Benchmark.ips do |x|
  x.report('via_direct') { via_direct }
  x.report('via_constant') { via_constant }

  x.compare!
end

Benchmark.memory do |x|
  x.report('via_direct') { 100.times { via_direct } }
  x.report('via_constant') { 100.times { via_constant } }

  x.compare!
end


puts '```'
