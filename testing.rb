require 'sitemaps'
require 'saxerator'
require 'memory_profiler'
require 'sitemaps/streamer'
require 'net/http'

require 'benchmark'

def print_memory_usage
  memory_before = `ps -o rss= -p #{Process.pid}`.to_i
  yield
  memory_after = `ps -o rss= -p #{Process.pid}`.to_i

  puts "Memory: #{((memory_after - memory_before) / 1024.0).round(2)} MB"
end

sitemap = File.open('sitemap-1.xml')

print_memory_usage do
  Sitemaps.parse(sitemap).entries.each do |entry|
    puts entry.loc
  end
end
# .parse uses emory: 108.15 MB

# print_memory_usage do
#   stream = Sitemaps.stream(sitemap)
#   stream.for_tag(:url).each do |url|
#     puts url[:loc]
#   end
# end
# .stream uses Memory: 0.27 MB






# MemoryProfiler.report do
#   Sitemaps.parse(sitemap)
# end.pretty_print

# Total allocated: 1141147694 bytes (14088410 objects)
# Total retained:  12509 bytes (24 objects)

# allocated memory by gem
# -----------------------------------
# 1039043545  rexml
#   39512277  time
#   36890272  set
#   18582072  uri
#    7119528  sitemaps_parser-1

# testing.rb(main):009:0> MemoryProfiler.report do
# testing.rb(main):010:1*   Sitemaps.parse(sitemap)
# testing.rb(main):011:1> end.pretty_print
# Total allocated: 12558106 bytes (151347 objects)
# Total retained:  12237 bytes (22 objects)

# allocated memory by gem
# -----------------------------------
#   11335637  rexml
#     605781  time
#     323760  set
#     217048  uri
#       75880  sitemaps_parser-1


# MemoryProfiler.report do
#   stream = Sitemaps.stream(sitemap)
#   stream.all
# end.pretty_print

# Total allocated: 348350426 bytes (4478558 objects)
# Total retained:  10026 bytes (94 objects)

# allocated memory by gem
# -----------------------------------
#  231539301  rexml
#   79664772  saxerator-0.9.9
#   36890272  set
#     232971  rubygems
#      23110  forwardable

# testing.rb(main):027:0> MemoryProfiler.report do
# testing.rb(main):028:1*   stream = Sitemaps.stream(sitemap)
# testing.rb(main):029:1>   stream.all
# testing.rb(main):030:1> end.pretty_print
# Total allocated: 3862312 bytes (51682 objects)
# Total retained:  10026 bytes (94 objects)

# allocated memory by gem
# -----------------------------------
#     2511149  rexml
#     771322  saxerator-0.9.9
#     323760  set
#     232971  rubygems
#       23110  forwardable