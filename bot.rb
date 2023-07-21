# frozen_string_literal: true

require 'dotenv/load'
require 'discordrb'

class SoupBot
  def self.bot
    @@bot ||= Discordrb::Bot.new(token: ENV.fetch('DISCORD_TOKEN', nil), intents: [])
    @@bot
  end

  def self.with_bot(&b)
    b.call(self.bot)
  end

  def self.on_ready(ev)
    self.bot.update_status(:online, "contented purring", nil, nil, false, 2)
  end

  def self.run
    Dir.glob(File.join(File.expand_path('../commands', __FILE__), '*.rb')) do |f|
      require f
    end

    self.bot.ready(&method(:on_ready))
    self.bot.run
  end
end

if __FILE__ == $0
  SoupBot.run
end
