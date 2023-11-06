# frozen_string_literal: true

require "rss"
require "open-uri"
require "nokogiri"

module Oak
  module Reddit
    REDDIT = "https://www.reddit.com/r//.rss"

    def configure_reddit
      on :privmsg, :do_reddit
    end

    def do_reddit(evt)
      case evt.message
      when /^\.reddit (.*) (.*)/
        URI.parse(REDDIT[0..24] + ::Regexp.last_match(1) + REDDIT[25..]).open("User-Agent" => "Ruby/3.2") do |rss|
          feed = RSS::Parser.parse(rss)
          feed.items.take(::Regexp.last_match(2).to_i).each do |item|
            say "\2#{Nokogiri::HTML(item.title.to_s).text}\n#{Nokogiri::HTML(item.link.to_s).xpath("//@href")}"
          end
        end
      when /^\.reddit/
        say ".reddit [sub] [n]"
      end
    end
  end
end
