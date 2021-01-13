# frozen_string_literal: true

require 'bundler/setup'
require 'discordrb'

class Unchimpo
  attr_reader :non_overlap

  def initialize(non_overlap = generate_non_overlap?)
    @non_overlap = non_overlap
  end

  def input(text)
    return self unless @non_overlap && %w[うんち ちんぽ うんちんぽ].include?(text)

    Unchimpo.new(@non_overlap.call(text))
  end

  def lose?
    @non_overlap.nil?
  end

  private

  def generate_non_overlap?(former = nil)
    lambda do |latter|
      return generate_non_overlap?(latter) unless latter == former
    end
  end
end

bot = Discordrb::Bot.new token: ENV['UNCHIMPO_TOKEN']
game = nil

bot.message(content: 'うんちんぽ') do |event|
  if game.nil?
    game = Unchimpo.new
    event.respond('うんちんぽしりとり！w')
  end
end

bot.message do |event|
  break if game.nil?

  game = game.input(event.content)
  if game.lose?
    event.respond("#{event.author.mention} お前の負けw")
    game = nil
  end
end

bot.run
