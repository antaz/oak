# frozen_string_literal: true

require "iirc"
require "net/http"
require "json"
require "llm"

module Oak
  module Gpt
    llm = LLM.openai(key: ENV["OPENROUTER_API_KEY"], host: "openrouter.ai", base_path: "api/v1")
    AGENT = LLM::Agent.new(llm, stream: $stdout, model: "openrouter/free")

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
      res = AGENT.ask prompt
      res.content
    rescue Faraday::ClientError
      "rate limited, try again later"
    end
  end
end
