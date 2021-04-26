require 'date'
require './lib/key_breaker'

describe KeyBreaker do
  describe '#initialize' do
    it 'exists' do
      keybreaker = KeyBreaker.new

      expect(keybreaker).is_a? KeyBreaker
    end
  end

  describe '#find_key' do
    it 'calculates the key from the shifts and offsets' do
      shifts = [14, 5, 5, -19]
      offsets = [6, 3, 2, 4]

      expect(KeyBreaker.find_key(shifts, offsets)).to eq '08304'
    end

    it 'works for any combination of shifts and offsets' do
      shifts = [3, 27, 73, 20]
      offsets = [1, 0, 2, 5]

      expect(KeyBreaker.find_key(shifts, offsets)).to eq '02715'
    end
  end

  describe '#find_true_keys' do
    it 'finds true shift keys using formatted sets of possible keys' do
      possible_keys = [
        ['08', '35', '62', '89'],
        ['02', '29', '56', '83'],
        ['03', '30', '57', '84'],
        ['04', '31', '58', '85']
      ]

      expected = {
        A: '08',
        B: '83',
        C: '30',
        D: '04'
      }
      expect(KeyBreaker.find_true_keys(possible_keys)).to eq expected
    end
  end

  describe '#possible_keys_by_position' do
    it 'calculates all possible keys for each position' do
      shifts = [14, 5, 5, -19]
      offsets = [6, 3, 2, 4]

      actual = KeyBreaker.possible_keys_by_position(shifts, offsets)
      expected = [
        [8, 35, 62, 89],
        [2, 29, 56, 83],
        [3, 30, 57, 84],
        [4, 31, 58, 85]
      ]
      expect(actual).to eq expected
    end
  end

  describe '#key_baselines' do
    it 'calculates key baselines' do
      shifts = [14, 5, 5, -19]
      offsets = [6, 3, 2, 4]

      expected = [8, 2, 3, 4]
      expect(KeyBreaker.key_baselines(shifts, offsets)).to eq expected
    end
  end

  describe '#normalize' do
    it 'normalizes shifts to within range 0-27' do
      shifts = [14, 5, 5, -19]

      expect(KeyBreaker.normalize(shifts)).to eq [14, 5, 5, 8]
    end
  end

  describe '#format_keys' do
    it 'formats keys as strings with zero padding on the left' do
      keys = [6, 3, 2, 4]

      expected = ['06', '03', '02', '04']
      expect(KeyBreaker.format_keys(keys)).to eq expected
    end
  end
end
