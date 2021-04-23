require 'date'
require './lib/enigma'

describe Enigma do
  describe '#initialize' do
    it 'exists' do
      enigma = Enigma.new

      expect(enigma).is_a? Enigma
    end
  end

  describe '#encrpyt' do
    enigma = Enigma.new

    expect(engima.encrypt("hello world", "02715", "040895")).to eq "keder ohulw"
  end
end
