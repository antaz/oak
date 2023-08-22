# frozen_string_literal: true

require "iirc"
require "net/http"
require "json"

module Oak
  module Weather
    API = "http://api.openweathermap.org/data/2.5/weather"

    def configure_weather
      on :privmsg, :do_weather
    end

    def do_weather evt
      case evt.message
      when /^\.weather (.*)/
        say weather $1
      when /^\.weather/
        say ".weather [city]"
      end
    end

    private

    def weather query
      uri = URI(API)
      params = {q: query, units: "metric", APPID: ENV["OWM_TOKEN"]}
      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)
      weather = JSON.parse(res.body)
      "#{weather["name"]}: #{weather["weather"][0]["description"]}, #{weather["main"]["temp"]} °C, #{weather["main"]["humidity"]}%, #{weather["wind"]["speed"].to_f * 3.6} KpH" if res.code == "200"
    end
  end
end
