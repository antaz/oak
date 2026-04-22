# frozen_string_literal: true

require "openai"
require "iirc"
require "net/http"
require "json"

module Oak
  # ChatGPT API
  module Gpt
    CLIENT = OpenAI::Client.new(
      access_token: ENV["OPENROUTER_API_KEY"],
      uri_base: "https://openrouter.ai/api"
    )

    def configure_gpt
      on :privmsg, :do_gpt
    end

    def do_gpt(evt)
      case evt.message
      when /^\.chat (.*)/
        prompt = ::Regexp.last_match(1)
        say chat prompt
      when /^\.chat/
        say ".chat [prompt]"
      end
    end

    private

    def chat(prompt)
      response = CLIENT.chat(
        parameters: {
          model: ENV.fetch("OPENROUTER_MODEL", "openrouter/free"),
          messages: [{role: "system", content: "You are chatting in IRC. Be concise and casual. No markdown, no formatting, no bullet points. Plain text only. Keep responses short."}, {role: "user", content: prompt}],
          temperature: 0.7
        }
      )
      response.dig("choices", 0, "message", "content")
    end
  end
end
