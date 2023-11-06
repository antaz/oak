# frozen_string_literal: true

require "iirc"
require "json"

module Oak
  module UrbanDict
    API = "https://api.urbandictionary.com/v0/define"

    def configure_urbandict
      on :privmsg, :do_urbandict
    end

    def do_urbandict(evt)
      case evt.message
      when /^\.ud (\d+) (.*)/
        say urbandict(::Regexp.last_match(2), ::Regexp.last_match(1).to_i)
      when /^\.ud (.*)/
        say urbandict(::Regexp.last_match(1), 1)
      when /^\.ud/
        say ".ud [term]"
      end
    end

    private

    def urbandict(term, n)
      uri = URI(API)
      params = {term: term.capitalize}
      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)
      definition = JSON.parse(res.body)
      definition["list"][n - 1]["definition"] if res.code == "200"
    end
  end
end
