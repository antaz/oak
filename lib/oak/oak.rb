# frozen_string_literal: true

require "iirc"
require "oak/gpt"
require "oak/weather"
require "oak/wolfram"
require "digest"
require "oak/throttle"
require "oak/trunc"

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
        say ".weather [city]"
        say ".wolfram [prompt]"
      end
    end
  end
end
