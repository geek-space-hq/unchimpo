# frozen_string_literal: true

require 'bundler/setup'
require 'discordrb'

class Unchimpo
  attr_reader :non_overlap

  def initialize(non_overlap = generate_non_overlap?)
    @non_overlap = non_overlap
  end

  def input(text)
    Unchimpo.new(@non_overlap.call(text))
  end

  def lose?
    !@non_overlap
  end

  private

  def generate_non_overlap?(former = nil)
    lambda do |latter|
      return generate_non_overlap?(latter) unless violate?(former, latter)
    end
  end

  def violate?(former, latter)
    latter == former || !%w[うんち ちんぽ うんちんぽ].include?(latter)
  end
end

bot = Discordrb::Bot.new token: ENV['UNCHIMPO_TOKEN']
game = nil

bot.message(content: 'うんちんぽ', in: 'トイレ') do |event|
  if game.nil?
    game = Unchimpo.new
    event.respond('うんちんぽしりとり！w')
  end
end

bot.message(in: 'トイレ') do |event|
  break if game.nil?

  game = game.input(event.content)
  if game.lose?
    event.respond("#{event.author.mention} お前の負けw")
    game = nil
  end
end

bot.run
