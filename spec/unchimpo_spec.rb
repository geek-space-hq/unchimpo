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

    it 'ignoew other than うんちんぽ, うんち, ちんぽ' do
      expect(subject.input('うんち').non_overlap).not_to eq subject.non_overlap
      expect(subject.input('ちんぽ').non_overlap).not_to eq subject.non_overlap
      expect(subject.input('うんちんぽ').non_overlap).not_to eq subject.non_overlap
      expect(subject.input('うんちいいいい').non_overlap).to eq subject.non_overlap
    end
  end

  describe '#lose?' do
    it 'judge as losing when your text overlaps' do
      expect(
        subject.input('うんち').input('うんち').lose?
      ).to eq true
    end
  end
end
