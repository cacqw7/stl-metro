#!/usr/bin/env ruby

require 'gtfs_reader'

GtfsReader.config do
  return_hashes true
  # verbose true #uncomment for verbose output
  sources do
    sample do
      url 'ftp://metrostlouis.org/Transit/google_transit.zip' # you can also use a filepath here
      before { |etag| puts "Processing source with tag #{etag}..." }
      handlers do
        agency {|row| puts "Read Agency: #{row[:agency_name]}" }
        routes {|row| puts "Read Route: #{row[:route_long_name]}" }
      end
    end
  end
end

GtfsReader.update :sample # or GtfsReader.update_all!
