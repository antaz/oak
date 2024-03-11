# frozen_string_literal: true

require "iirc"
require "oak/gpt"
require "oak/weather"
require "oak/wolfram"
require "digest"
require "oak/threaded"
require "oak/throttle"
require "oak/trunc"
require "oak/uptime"
require "oak/ud"
require "oak/lichess"
require "oak/hash"
require "oak/resolve"
require "oak/news"
require "oak/reddit"
require "oak/wiki"

module Oak
  class Oak < IIRC::IRCv3Bot
    include IIRC::AutoJoin
    include IIRC::AcceptInvites
    include IIRC::Verbs
    include IIRC::PrintIO
    include IIRC::Throttle
    include IIRC::Truncate
    include IIRC::Ambient
    include IIRC::Threaded

    include Gpt
    include Weather
    include Wolfram
    include Uptime
    include UrbanDict
    include Lichess
    include Hash
    include Resolve
    include News
    include Reddit
    include Wiki

    def throttle_ratio
      1/2r
    end

    def autojoin_channels
      @autojoin_channels ||= []
    end

    def on_privmsg(evt)
      case evt.message
      when /^(\.help)|^(\.\?)/
        say "available commands:"
        say ".gpt <prompt>"
        say ".ud <term>"
        say ".weather <city>"
        say ".wolfram <prompt>"
        say ".uptime"
        say ".rot13 <string>"
        say ".md5 <string>"
        say ".sha1 <string>"
        say ".tv <username>"
        say ".rating <username>"
      end
    end
  end
end
