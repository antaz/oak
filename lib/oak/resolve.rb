# frozen_string_literal: true

require "nokogiri"
require "open-uri"
require "iirc"

module Oak
  # Resolve URL and get title
  module Resolve
    def configure_resolve
      on :privmsg, :do_resolve
    end

    def do_resolve(evt)
      URI::DEFAULT_PARSER.make_regexp(["https", "http"]).match(evt.message).to_a.each do |url|
        say resolve url
      end
    end

    private

    def resolve(url)
      URI.parse(url).open do |f|
        doc = Nokogiri::HTML(f, nil, Encoding::UTF_8.to_s)
        title = doc.at_css("title").text
        return title
      end
    end
  end
end
