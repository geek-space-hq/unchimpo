# frozen_stinrg_literal: true

require 'rspec'
require_relative '../main'

RSpec.describe Unchimpo do
  subject { Unchimpo.new }

  describe '#input' do
    it 'return unchimpo instance' do
      unchimpo = subject.input('うんちんぽ')
      expect(unchimpo.non_overlap.call('うんちんぽ')).to be_nil
    end
  end

  describe '#lose?' do
    it 'judge as losing when your text overlaps' do
      expect(
        subject.input('うんち').input('うんち').lose?
      ).to eq true
    end

    it 'judge as losing when you say other than うんち, ちんぽ, うんちんぽ' do
      expect(subject.input('うんちいいい').lose?).to eq true
      expect(subject.input('アンパンマン').lose?).to eq true
    end
  end
end
