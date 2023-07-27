# frozen_string_literal: true

require "thor"
require "oak/oak"
require "oak/gpt"

module Oak
  # Command line interface
  class CLI < Thor
    desc "go", "connects to libera server by default"
    method_option :host, aliases: "-h", desc: "Network host address"
    method_option :nick, aliases: "-n", desc: "Network nick"
    method_option :channel, aliases: "-c", desc: "Channel to join"
    def go
      Oak.run(options[:host], nick: options[:nick]) { |bot| bot.autojoin_channels.push(options[:channel]) }
    end
  end
end
