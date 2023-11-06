# frozen_string_literal: true

require "wikipedia"

module Oak
  module Wiki
    def configure_wiki
      on :privmsg, :do_wiki
    end

    def do_wiki(evt)
      case evt.message
      when /^\.wiki (.*)/
        page = Wikipedia.find(::Regexp.last_match(1))
        say page.summary.split("\n")[0] if page
      end
    end
  end
end
