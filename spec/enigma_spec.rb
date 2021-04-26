require 'date'
require './lib/enigma'
require './lib/key_breaker'

describe Enigma do
  before :each do
    @enigma = Enigma.new
  end

  describe '#initialize' do
    it 'exists' do
      expect(@enigma).is_a? Enigma
    end
  end

  describe '#encrypt' do
    it 'returns an encrypted version of input with key and date given' do
      expected = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }
      expect(@enigma.encrypt('hello world', '02715', '040895')).to eq expected
    end

    it 'returns an encrypted version of input with message and key given' do
      allow(Keyable).to receive(:date_today) { '040895' }

      expected = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }
      expect(@enigma.encrypt('hello world', '02715')).to eq expected
    end

    it 'returns an encrypted version of input with only message given' do
      allow(Keyable).to receive(:random_key) { '02715' }
      allow(Keyable).to receive(:date_today) { '040895' }

      expected = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }
      expect(@enigma.encrypt('hello world')).to eq expected
    end

    it 'can handle uppercase letters in input string' do
      expected = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }
      expect(@enigma.encrypt('hEllo WorLd', '02715', '040895')).to eq expected
    end

    it 'can handle unexpected characters in input string' do
      expected = {
        encryption: 'kede0 ohulw!',
        key: '02715',
        date: '040895'
      }
      expect(@enigma.encrypt('hEll0 WorLd!', '02715', '040895')).to eq expected
    end
  end

  describe '#decrypt' do
    it 'returns a decrypted version of input string with key and date given' do
      expected = {
        decryption: 'hello world',
        key: '02715',
        date: '040895'
      }
      expect(@enigma.decrypt('keder ohulw', '02715', '040895')).to eq expected
    end

    it 'returns an decrypted version of input with message and key given' do
      allow(Keyable).to receive(:date_today) { '040895' }

      expected = {
        decryption: 'hello world',
        key: '02715',
        date: '040895'
      }
      expect(@enigma.decrypt('keder ohulw', '02715')).to eq expected
    end

    it 'can handle uppercase letters in input string' do
      expected = {
        decryption: 'hello world',
        key: '02715',
        date: '040895'
      }
      expect(@enigma.decrypt('keDer oHulw', '02715', '040895')).to eq expected
    end

    it 'can handle unexpected characters in input string' do
      expected = {
        decryption: 'hell0 world!',
        key: '02715',
        date: '040895'
      }
      expect(@enigma.decrypt('keDe0 oHulw!', '02715', '040895')).to eq expected
    end
  end

  describe '#crack' do
    it 'returns a decrypted message without a key' do
      expected = {
        decryption: 'hello world end',
        key: '08304',
        date: '291018'
      }
      expect(@enigma.crack('vjqtbeaweqihssi', '291018')).to eq expected
    end
  end

  describe '#update_by_index' do
    it 'returns encrypted letter indexes with positive direction' do
      shifts = [3, 27, 73, 20]
      letter_indexes = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]

      expected = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]
      expect(@enigma.update_by_index(letter_indexes, shifts)).to eq expected
    end

    it 'returns decrypted letter indexes with negative direction' do
      shifts = [3, 27, 73, 20]
      letter_indexes = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]

      expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
      expect(@enigma.update_by_index(letter_indexes, shifts, -1)).to eq expected
    end
  end

  describe '#shift_by_n' do
    it 'shifts an index by an n value over letters' do
      index = 0
      n = 3

      expect(@enigma.shift_by_n(index, n)).to eq 3
    end

    it 'returns the index if it is not a letter or space' do
      index = '!'
      n = 3

      expect(@enigma.shift_by_n(index, n)).to eq '!'
    end
  end

  describe '#convert_to_indexes' do
    it 'converts a string into an array of indexes' do
      message = 'hello world'

      expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
      expect(@enigma.convert_to_indexes(message)).to eq expected
    end
  end

  describe '#convert_to_string' do
    it 'converts an array of indexes into a string' do
      index_array = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]

      expect(@enigma.convert_to_string(index_array)).to eq 'keder ohulw'
    end
  end

  describe '#find_n' do
    it 'returns the n value (shift) for the A shift, index 0' do
      index = 0
      shifts = [3, 27, 73, 20]

      expect(@enigma.find_n(index, shifts)).to eq 3
    end

    it 'returns the n value (shift) for any index' do
      index = 6
      shifts = [3, 27, 73, 20]

      expect(@enigma.find_n(index, shifts)).to eq 73
    end
  end

  describe '#shifts_from_codebreaker' do
    it 'calculates the four shifts' do
      message = 'vjqtbeaweqihssi'
      codebreaker = ' end'

      actual = @enigma.shifts_from_codebreaker(message, codebreaker)
      expected = [14, 5, 5, -19]
      expect(actual).to eq expected
    end
  end

  describe '#shift_rotations' do
    it 'calculates rotations needed for proper shift position' do
      message = 'vjqtbeaweqihssi'
      codebreaker = ' end'

      actual = @enigma.shift_rotations(message, codebreaker)
      expected = 1
      expect(actual).to eq expected
    end
  end

  describe '#get_shifts' do
    it 'calculates the four shifts' do
      key = '02715'
      date = '040895'

      expect(@enigma.get_shifts(key, date)).to eq [3, 27, 73, 20]
    end
  end

  describe '#shift_keys' do
    it 'returns an array of shift Keys' do
      expect(@enigma.shift_keys('02715')).to eq [0o2, 27, 71, 15]
    end
  end

  describe '#shift_offsets' do
    it 'returns an array of shift Offsets' do
      expect(@enigma.shift_offsets('040895')).to eq [1, 0, 2, 5]
    end
  end

  describe '#letters' do
    it 'creates the array of letters' do
      expected = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i',
                  'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
                  's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ']
      expect(@enigma.letters).to eq expected
    end
  end
end
