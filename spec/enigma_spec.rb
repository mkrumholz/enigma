require 'date'
require './lib/enigma'

describe Enigma do
  describe '#initialize' do
    it 'exists' do
      enigma = Enigma.new

      expect(enigma).is_a? Enigma
    end
  end

  describe '#encrypt' do
    it 'returns an encrypted version of input string' do
      enigma = Enigma.new

      expect(enigma.encrypt('hello world', '02715', '040895')).to eq 'keder ohulw'
    end
  end

  describe '#decrypt' do
    it 'returns a decrypted version of input string' do
      enigma = Enigma.new

      expect(enigma.decrypt('keder ohulw', '02715', '040895')).to eq 'hello world'
    end
  end

  describe '#encrypt_by_index' do
    it 'returns an array of encrypted letter indexes' do
      enigma = Enigma.new
      shifts = [3, 27, 73, 20]
      letter_indexes = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]

      expected = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]
      expect(enigma.encrypt_by_index(letter_indexes, shifts)).to eq expected
    end
  end

  describe '#decrypt_by_index' do
    it 'returns an array of decrypted letter indexes' do
      enigma = Enigma.new
      shifts = [3, 27, 73, 20]
      letter_indexes = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]

      expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
      expect(enigma.decrypt_by_index(letter_indexes, shifts)).to eq expected
    end
  end

  describe '#convert_to_indexes' do
    it 'converts a string into an array of indexes' do
      enigma = Enigma.new
      message = 'hello world'

      expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
      expect(enigma.convert_to_indexes(message)).to eq expected
    end
  end

  describe '#convert_to_string' do
    it 'converts an array of indexes into a string' do
      enigma = Enigma.new
      index_array = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]

      expect(enigma.convert_to_string(index_array)).to eq 'keder ohulw'
    end
  end

  describe '#find_n' do
    it 'returns the n value (shift) for the A shift, index 0' do
      enigma = Enigma.new
      index = 0
      shifts = [3, 27, 73, 20]

      expect(enigma.find_n(index, shifts)).to eq 3
    end

    it 'returns the n value (shift) for any index' do
      enigma = Enigma.new
      index = 6
      shifts = [3, 27, 73, 20]

      expect(enigma.find_n(index, shifts)).to eq 73
    end
  end

  # describe '#generate_key' do
  #   enigma = Enigma.new
  #
  #   expect(enigma.generate_key.length).to eq 5
  # end

  describe '#get_shifts' do
    it 'calculates the four shifts' do
      enigma = Enigma.new
      key = '02715'
      date = '040895'

      expect(enigma.get_shifts(key, date)).to eq [3, 27, 73, 20]
    end
  end

  describe '#shift_keys' do
    it 'returns an array of shift Keys' do
      enigma = Enigma.new

      expect(enigma.shift_keys('02715')).to eq [0o2, 27, 71, 15]
    end
  end

  describe '#shift_offsets' do
    it 'returns an array of shift Offsets' do
      enigma = Enigma.new

      expect(enigma.shift_offsets('040895')).to eq [1, 0, 2, 5]
    end
  end

  describe '#letters' do
    it 'creates the array of letters' do
      enigma = Enigma.new

      expected = ['a', 'b', 'c', 'd',
                  'e', 'f', 'g', 'h',
                  'i', 'j', 'k', 'l',
                  'm', 'n', 'o', 'p',
                  'q', 'r', 's', 't',
                  'u', 'v', 'w', 'x',
                  'y', 'z', ' ']
      expect(enigma.letters).to eq expected
    end
  end
end
