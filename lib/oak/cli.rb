# frozen_string_literal: true

require "thor"
require "oak/oak"
require "yaml"

module Oak
  # Command line interface
  class CLI < Thor
    desc "go [FILE]", "Use config file to configure client"
    def go(file = "config.yml")
      config = YAML.load_file(file)
      config["networks"].map do |network|
        Oak.run(network["host"], nick: network["nick"]) do |bot|
          bot.autojoin_channels.concat(network["channels"])
          at_exit do
            bot.part(network["channels"].join(","), "Bye! see you later.")
            bot.quit("Bye! see you later.")
          end
        end
      end
    end
  end
end
