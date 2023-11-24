# frozen_string_literal: true

require "openai"
require "iirc"
require "net/http"
require "json"

module Oak
  # ChatGPT API
  module Gpt
    CLIENT = OpenAI::Client.new(access_token: ENV["OPENAI_TOKEN"])

    def configure_gpt
      on :privmsg, :do_gpt
    end

    def do_gpt(evt)
      case evt.message
      when /^\.gpt (.*)/
        prompt = ::Regexp.last_match(1)
        say chat prompt
      when /^\.gpt/
        say ".gpt [prompt]"
      end
    end

    private

    def chat(prompt)
      response = CLIENT.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [{role: "user", content: prompt}],
          temperature: 0.7
        }
      )
      response.dig("choices", 0, "message", "content")
    end
  end
end
