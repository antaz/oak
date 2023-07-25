# frozen_string_literal: true

require "net/http"
require "uri"
require "json"

module Oak
  # ChatGPT API
  module Gpt
    API = "https://api.openai.com/v1"
    TOKEN = ENV["OPENAI_TOKEN"]
    @HEADER = { "Content-Type": "application/json", "Authorization": "Bearer #{TOKEN}" }
    @context = []

    def self.completion(name, prompt)
      uri = URI.parse "#{API}/chat/completions"
      @context.push({ "role": "user", "name": name, "content": prompt })
      res = Net::HTTP.start(uri.host, use_ssl: true) do |http|
        req = Net::HTTP::Post.new uri, @HEADER
        req.body = { "model": "gpt-3.5-turbo", "messages": @context }.to_json
        http.request req
      end
      case res.code
      when "200"
        @context.push(JSON.parse(res.body)["choices"][0]["message"])
        @contex.shift if @context.length >= 10
        JSON.parse(res.body)["choices"][0]["message"]["content"]
      else
        "Error: #{res.message}"
      end
    end

    def self.image(prompt)
      uri = URI.parse "#{API}/images/generations"
      res = Net::HTTP.start(uri.host, use_ssl: true) do |http|
        req = Net::HTTP::Post.new uri, @HEADER
        req.body = { "prompt": prompt, "n": 2, "size": "512x512" }.to_json
        http.request req
      end
      case res.code
      when "200"
        JSON.parse(res.body)["data"][0]["url"]
      else
        "Error: #{res.message}"
      end
    end
  end
end
