require 'date'
require './lib/key_breaker'

describe KeyBreaker do
  describe '#initialize' do
    it 'exists' do
      keybreaker = KeyBreaker.new

      expect(keybreaker).is_a? KeyBreaker
    end
  end
end
