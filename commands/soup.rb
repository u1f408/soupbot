# frozen_string_literal: true

SoupBot.bot.application_command(:soup) do |ev|
  em = Discordrb::Webhooks::Embed.new
  em.image = Discordrb::Webhooks::EmbedImage.new(url: SoupBot.get_random_image)
  em.color = 0xf2a65a

  ev.respond(embeds: [em], ephemeral: false)
end
