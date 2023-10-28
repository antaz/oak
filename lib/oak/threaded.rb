# frozen_string_literal: true

module IIRC
  module Threaded
    def on_privmsg
      Thread.new { super(evt) }
    end
  end
end
