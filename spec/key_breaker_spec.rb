require 'date'
require './lib/enigma'

describe KeyBreaker do
  describe '#initialize' do
    it 'exists' do
      keybreaker = KeyBreaker.new

      expect(keybreaker).is_a? KeyBreaker
    end
  end
end
