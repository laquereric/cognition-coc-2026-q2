# frozen_string_literal: true

require "cognition_coc_2026_q2/message"
require "cognition_coc_2026_q2/matcher"
require "cognition_coc_2026_q2/responder"
require "cognition_coc_2026_q2/plugins/base"
require "cognition_coc_2026_q2/plugins/default"

module CognitionCoc2026Q2
  class Bot
    attr_accessor :plugins, :matchers

    def initialize
      # Default plugin, responds to "ping" with "PONG" and provides help text
      register(CognitionCoc2026Q2::Plugins::Default)
    end

    def process(msg, metadata = {})
      if msg.respond_to? :command
        process_msg(msg)
      else
        process_string(msg.to_s, metadata)
      end
    end

    def register(klass)
      return false if plugin_names.include? klass.to_s
      plugins << klass.new(self)
    end

    def reset
      @matchers = []
      @plugins = []
      register(CognitionCoc2026Q2::Plugins::Default)
    end

    def plugin_names
      plugins.map { |p| p.class.name }
    end

    def help
      matchers.flat_map(&:help)
    end

    private

    def process_msg(msg)
      response = false
      matchers.each do |matcher|
        if matcher.attempt(msg) != false
          response = matcher.response
          break
        end
      end
      response ? response : not_found(msg.command)
    end

    def process_string(message, metadata = {})
      process_msg(CognitionCoc2026Q2::Message.new(message.strip, metadata))
    end

    def matchers
      plugins.flat_map(&:matchers).compact
    end

    def plugins
      @plugins ||= []
    end

    def not_found(message)
      "No such command: #{message}\nUse 'help' for available commands!"
    end
  end
end
