# frozen_string_literal: true

require "minitest/autorun"
require "cognition-coc-2026-q2"

class DefaultPluginTest < Minitest::Test
  def setup
    @bot = CognitionCoc2026Q2::Bot.new
  end

  def test_returns_help
    help = "help - Lists all commands with help\nhelp <command> - Lists help for <command>\nping - Test if the endpoint is responding. Returns PONG."
    assert_equal help, @bot.process("help")
  end

  def test_returns_filtered_help
    help = "ping - Test if the endpoint is responding. Returns PONG."
    assert_equal help, @bot.process("help ping")
  end
end
