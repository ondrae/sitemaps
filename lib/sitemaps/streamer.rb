module Sitemaps
  # Stream XML Sitemaps
  module Streamer
    def self.stream(source)
      # xml = Sitemaps::Fetcher.fetch(source)
      Saxerator.parser(source) do |config|
        config.symbolize_keys!
      end
    end
  end
end
