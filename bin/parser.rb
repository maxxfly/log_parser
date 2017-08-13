#!/usr/bin/env ruby

require_relative '../lib/log_parser'

log_parser = LogParser.new(ARGV[0])
puts log_parser.output
