# frozen_string_literal: true

SOUP_PICTURES = open('soup_pictures.txt', 'r') { |f| f.readlines.map(&:strip) }

SoupBot.bot.application_command(:soup) do |ev|
  em = Discordrb::Webhooks::Embed.new
  em.image = Discordrb::Webhooks::EmbedImage.new(url: SOUP_PICTURES.sample)
  em.color = 0xf2a65a

  ev.respond(embeds: [em], ephemeral: false)
end
