# frozen_string_literal: true

require 'iirc'
require 'net/http'
require 'json'

module Oak
  module Wolfram
    API = 'http://api.wolframalpha.com/v1/result'

    def configure_wolfram
      on :privmsg, :do_wolfram
    end

    def do_wolfram(evt)
      case evt.message
      when /^\.wolfram (.*)/
        say wolfram ::Regexp.last_match(1)
      when /^\.wolfram/
        say '.wolfram [prompt]'
      end
    end

    private

    def wolfram(query)
      uri = URI(API)
      params = { i: query, units: 'metric', appid: ENV['WOLFRAM_TOKEN'] }
      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)
      res.body.to_s if res.code == '200'
    end
  end
end
