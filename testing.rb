require 'sitemaps'
require 'pry'
require 'pry-byebug'
require 'saxerator'
require 'memory_profiler'
require 'sitemaps/streamer'

# Sitemaps.stream('https://search.gov/sitemap.xml')
Sitemaps::Streamer.stream('https://search.gov/sitemap.xml')