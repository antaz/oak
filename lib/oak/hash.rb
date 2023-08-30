# frozen_string_literal: true

require "iirc"
require "digest"

module Oak
  module Hash
    def configure_hash
      on :privmsg, :do_hash
    end

    def do_hash evt
      case evt.message
      when /^\.sha1 (.*)/
        say Digest::SHA1.hexdigest $1
      when /^\.md5 (.*)/
        say Digest::MD5.hexdigest $1
      when /^\.rot13 (.*)/
        say $1.tr("A-Za-z", "N-ZA-Mn-za-m")
      end
    end
  end
end
