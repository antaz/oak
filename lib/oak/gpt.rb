# frozen_string_literal: true

require "iirc"
require "net/http"
require "json"
require "net/http"

module Oak
  module Gpt
    CLIENT = URI("https://openrouter.ai/api/v1/chat/completions")

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
      res = Net::HTTP.post(
        CLIENT,
        {
          model: "openrouter/free",
          messages: [
            { role: "system", content: "You're inside IRC as an assistant, be brief!" },
            { role: "user", content: prompt }]
        }.to_json,
        {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{ENV["OPENROUTER_API_KEY"]}"
        }
      )
      JSON.parse(res.body).dig("choices", 0, "message", "content")
    end
  end
end
