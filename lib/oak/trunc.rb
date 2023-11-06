# frozen_string_literal: true

module IIRC
  module Truncate
    module Verbs
      def msg(target, msg)
        msg.to_s.gsub(/(.{1,400})(?=\s|$)/, "\\1\n").lines do |line|
          super(target, line)
        end
      end
      alias_method :say, :msg
    end

    include Verbs
  end
end
