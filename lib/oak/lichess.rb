# frozen_string_literal: true

require "iirc"
require "json"

module Oak
  module Lichess
    API = "https://lichess.org/api"

    def configure_lichess
      on :privmsg, :do_lichess
    end

    def do_lichess evt
      case evt.message
      when /^\.tv (.*)/
        say tv $1
      when /^\.rating (.*)/
        say rating $1
      end
    end

    def tv(username)
      uri = URI("#{API}/user/#{username}")
      res = Net::HTTP.get_response(uri)
      if res.code == "200"
        data = JSON.parse(res.body, symbolize_names: true)
        "#{data[:url]}/tv"
      else
        "Error #{res.message}"
      end
    end

    def rating(username)
      uri = URI("#{API}/user/#{username}")
      res = Net::HTTP.get_response(uri)
      if res.code == "200"
        data = JSON.parse(res.body, symbolize_names: true)
        "#{data[:username]}: [rapid: #{data[:perfs][:rapid][:rating]}, blitz: #{data[:perfs][:blitz][:rating]}, bullet: #{data[:perfs][:bullet][:rating]}]"
      else
        "Error #{res.message}"
      end
    end
  end
end
