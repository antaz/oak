# frozen_string_literal: true

require "net/http"
require "json"
require "iirc"

module Oak
  # ChatGPT API
  module Gpt
    API = "https://api.openai.com/v1"

    def configure_completion
      on :privmsg, :do_completion
    end

    def do_completion(evt)
      case evt.message
      when /^\.gpt (.*)/
        prompt = ::Regexp.last_match(1)
        say completion evt.nick, evt.target, prompt
      when /^\.gpt/
        say ".gpt [prompt]"
      end
    end

    private

    def completion(name, user, prompt)
      header = {"Content-Type": "application/json", Authorization: "Bearer #{ENV["OPENAI_TOKEN"]}"}
      name = Digest::MD5.hexdigest name
      user = Digest::MD5.hexdigest user
      uri = URI.parse "#{API}/chat/completions"
      context = [{role: "user", name: name, content: prompt}]
      res = Net::HTTP.start(uri.host, use_ssl: true) do |http|
        req = Net::HTTP::Post.new uri, header
        req.body = {model: "gpt-3.5-turbo", messages: context, user: user, max_tokens: 2000, temperature: 0.2}.to_json
        http.request req
      end
      case res.code
      when "200"
        JSON.parse(res.body)["choices"][0]["message"]["content"]
      else
        "Error: #{res.message}"
      end
    end
  end
end
