# frozen_string_literal: true

require "tilt/haml"
require "tilt/erb"
require "haml"
class Anchor < CognitionCoc2026Q2::Plugins::Base
  match "ping me", :anchored_ping, help: {
    "ping me" => "Returns 'OK'"
  }

  def anchored_ping(*)
    "OK"
  end
end
