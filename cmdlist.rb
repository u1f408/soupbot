# frozen_string_literal: true

require_relative 'bot'

SoupBot.with_bot do |bot|
  bot.register_application_command(:soup, 'Get a picture of Him')
end
