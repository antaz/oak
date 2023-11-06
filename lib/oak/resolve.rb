# frozen_string_literal: true

require "net/http"
require "open-uri"
require "uri"
require "iirc"

module Oak
  # Resolve URL and get title
  module Resolve
    def configure_resolve
      on :privmsg, :do_resolve
    end

    def do_resolve(evt)
      URI.extract(evt.message).each do |url|
        say resolve url
      end
    end

    private

    def resolve(url)
      "\"#{URI.parse(url).open.read.scan(%r{<title>(.*?)</title>})[0][0]}\""
    end
  end
end
