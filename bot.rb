# frozen_string_literal: true

require 'dotenv/load'
require 'discordrb'

class SoupBot
  def self.bot
    @@bot ||= Discordrb::Bot.new(token: ENV.fetch('DISCORD_TOKEN', nil), intents: :none)
    @@bot
  end

  def self.with_bot(&b)
    b.call(self.bot)
  end

  def self.on_ready(ev)
    self.get_random_image
    self.bot.update_status('online', "contented purring (#{@@images.count} images)", nil, activity_type: 2)
  end

  def self.run
    Dir.glob(File.join(File.expand_path('../commands', __FILE__), '*.rb')) do |f|
      require f
    end

    self.bot.ready(&method(:on_ready))
    self.bot.run
  end

  def self.get_random_image
    @@base ||= ENV.fetch("IMAGE_BASE", "https://archive.catstret.ch/soup/")
    @@images ||= (Pathname.new(__dir__) / "soup_pictures.txt").open('r') do |fh|
      fh.readlines.map do |l|
        l.strip!
        next nil if l.nil? || l&.empty?
        l
      end.compact
    end

    url = @@images.sample
    url = @@base + url unless url.start_with? /(https?:)?\/\//
    url
  end
end

if __FILE__ == $0
  SoupBot.run
end
