# frozen_string_literal: true

module IIRC
  module Throttle
    def throttle_ratio
      1/1r
    end

    module Verbs
      def msg(target, msg)
        super
        sleep throttle_ratio
      end
      alias say msg
    end

    include Verbs
  end
end
