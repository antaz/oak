# frozen_string_literal: true

require "iirc"
require "oak/gpt"
require "digest"
require "oak/throttle"
require "oak/trunc"

module Oak
  class Oak < IIRC::IRCv3Bot
    include IIRC::AutoJoin
    include IIRC::Verbs
    include IIRC::PrintIO
    include IIRC::Throttle
    include IIRC::Truncate
    include IIRC::Ambient

    def throttle_ratio
      1/3r
    end

    def autojoin_channels
      @autojoin_channels ||= []
    end

    def on_privmsg(evt)
      case evt.message
      when /^\.gpt (.*)/
        prompt = ::Regexp.last_match(1)
        say Gpt.completion(evt.nick, prompt)
      when /^\.imagine (.*)/
        prompt = ::Regexp.last_match(1)
        say evt.target, Gpt.image(prompt)
      end
    end
  end
end
