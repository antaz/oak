# frozen_string_literal: true

require "iirc"
require "oak/gpt"

module Oak
  class Oak < IIRC::IRCv3Bot
    include IIRC::AutoJoin
    include IIRC::Verbs
    include IIRC::PrintIO
    include IIRC::Ambient

    # last time a message was sent for throttling
    @@last = Time.now

    def autojoin_channels; end

    def on_privmsg(evt)
      case evt.message
      when /^\.gpt (.*)/
        prompt = ::Regexp.last_match(1)
        completion = Gpt.completion(evt.nick, prompt).scan(/.{1,400}/).map { |s| s << "\n" }
        completion.map do |l|
          sleep 1 while (Time.now - @@last) < 1
          @@last = Time.now
          say evt.target, l
        end
      when /^\.imagine (.*)/
        prompt = ::Regexp.last_match(1)
        image = Gpt.image(prompt).scan(/.{1,400}/).map { |s| s << "\n" }.join
        say evt.target, image
      end
    end
  end
end
