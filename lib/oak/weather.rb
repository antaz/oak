# frozen_string_literal: true

require "iirc"
require "net/http"
require "json"
require "open-weather-ruby-client"

module Oak
  module Weather
    CLIENT = OpenWeather::Client.new(
      api_key: ENV["OWM_TOKEN"]
    )

    def configure_weather
      on :privmsg, :do_weather
    end

    def do_weather(evt)
      case evt.message
      when /^\.weather (.*)/
        say weather ::Regexp.last_match(1)
      when /^\.weather/
        say ".weather [city]"
      end
    end

    private

    def weather(location)
      data = CLIENT.current_weather(city: location, units: "metric")
      "#{data.name}: #{data.weather[0].description}, #{data.main.temp} °C, #{data.main.humidity}%, #{data.wind.speed_mph} mph"
    end
  end
end
