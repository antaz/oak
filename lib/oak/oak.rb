# frozen_string_literal: true

require "iirc"
require "oak/gpt"
require "oak/weather"
require "oak/wolfram"
require "digest"
require "oak/throttle"
require "oak/trunc"
require "oak/uptime"
require "oak/ud"

module Oak
  class Oak < IIRC::IRCv3Bot
    include IIRC::AutoJoin
    include IIRC::AcceptInvites
    include IIRC::Verbs
    include IIRC::PrintIO
    include IIRC::Throttle
    include IIRC::Truncate
    include IIRC::Ambient

    include Gpt
    include Weather
    include Wolfram
    include Uptime
    include UrbanDict

    def throttle_ratio
      1/2r
    end

    def autojoin_channels
      @autojoin_channels ||= []
    end

    def on_privmsg evt
      case evt.message
      when /^(\.help)|(\.\?)/
        say "available commands:"
        say ".gpt [prompt]"
        say ".ud [term]"
        say ".weather [city]"
        say ".wolfram [prompt]"
        say ".uptime"
      end
    end
  end
end
