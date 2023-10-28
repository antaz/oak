# frozen_string_literal: true

require 'iirc'

module Oak
  module Uptime
    TIME = Time.now

    def configure_uptime
      on :privmsg, :do_uptime
    end

    def do_uptime(evt)
      case evt.message
      when /^\.uptime/
        say uptime
      end
    end

    private

    def uptime
      secs = (Time.now - TIME).to_i
      mins = secs / 60
      hours = mins / 60
      days = hours / 24

      if days.positive?
        "#{days} days and #{hours % 24} hours"
      elsif hours.positive?
        "#{hours} hours and #{mins % 60} minutes"
      elsif mins.positive?
        "#{mins} minutes and #{secs % 60} seconds"
      elsif secs >= 0
        "#{secs} seconds"
      end
    end
  end
end
