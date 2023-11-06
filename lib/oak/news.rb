# frozen_string_literal: true

require "rss"
require "open-uri"

module Oak
  module News
    SOURCES = {
      "aj" => "https://www.aljazeera.com/xml/rss/all.xml",
      "cnn" => "http://rss.cnn.com/rss/edition.rss",
      "nyt" => "https://rss.nytimes.com/services/xml/rss/nyt/World.xml",
      "guardian" => "https://www.theguardian.com/international/rss"
    }

    def configure_news
      on :privmsg, :do_news
    end

    def do_news(evt)
      case evt.message
      when /^\.news/
        say "Availables sources: .aj, .cnn, .nyt, .guardian"
      end
      SOURCES.each do |src, url|
        case evt.message
        when /^\.#{src} (.*)/
          URI.parse(url).open do |rss|
            feed = RSS::Parser.parse(rss)
            feed.items.take(::Regexp.last_match(1).to_i).each do |item|
              say "\2#{item.title}\n#{item.link}"
            end
          end
        end
      end
    end
  end
end
