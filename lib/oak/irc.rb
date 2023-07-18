# frozen_string_literal: true

require "socket"

module Oak
  # IRC specification implementation
  class IRC
    def initialize(host = "irc.libera.chat", port = 6667)
      @sock = TCPSocket.new host, port
    end

    def loop
      ident
      while (line = @sock.gets)
        case line
        when /PING/
          pong
        when /376/
          join ["##testchannel"]
        end
        puts line
      end
    end

    def pong
      @sock.puts "PONG"
    end

    def nick(nickname)
      @sock.puts "NICK #{nickname}"
    end

    def user(name, realname)
      @sock.puts "USER #{name} 0 * #{realname}"
    end

    def ident
      nick "oak123"
      user "oak123", "Oak bot"
    end

    def join(chans)
      @sock.puts "JOIN #{chans.join " "}"
    end

    def close
      @sock.close
    end
  end
end
