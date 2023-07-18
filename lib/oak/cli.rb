require "thor"
require "oak/irc"

module Oak
    class CLI < Thor
        desc "connect", "conects to libera server by default"
        def connect()
            irc = IRC.new
            irc.loop
        end
    end
end