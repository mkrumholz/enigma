require './lib/keyable'

class Enigma
  include Keyable

  def encrypt(message, key = Keyable.random_key, date = Keyable.date_today)
    letter_indexes = convert_to_indexes(message)
    shifts = get_shifts(key, date)
    encrypted_indexes = encrypt_by_index(letter_indexes, shifts)
    { encryption: convert_to_string(encrypted_indexes),
      key: key,
      date: date }
  end

  def decrypt(message, key, date = Keyable.date_today)
    letter_indexes = convert_to_indexes(message)
    shifts = get_shifts(key, date)
    decrypted_indexes = decrypt_by_index(letter_indexes, shifts)
    { decryption: convert_to_string(decrypted_indexes),
      key: key,
      date: date }
  end

  def crack(message, date = Keyable.date_today)
    codebreaker = ' end'
    shifts = shifts_from_codebreaker(message, codebreaker)
    key = find_key(shifts, date)
    decrypt(message, key, date)
  end

  def encrypt_by_index(letter_indexes, shifts)
    index = 0
    letter_indexes.map do |letter_index|
      n = find_n(index, shifts)
      index += 1
      shift_by_n(letter_index, n)
    end
  end

  def decrypt_by_index(letter_indexes, shifts)
    index = 0
    letter_indexes.map do |letter_index|
      n = find_n(index, shifts) * -1
      index += 1
      shift_by_n(letter_index, n)
    end
  end

  def shift_by_n(index, n)
    if index.is_a? String
      index
    else
      (index + n) % 27
    end
  end

  def convert_to_indexes(message)
    message = message.downcase.chars
    message.map do |letter|
      if letters.include?(letter)
        letters.find_index(letter)
      else
        letter
      end
    end
  end

  def convert_to_string(index_array)
    index_array.map do |index|
      if index.is_a? String
        index
      else
        letters[index]
      end
    end.join
  end

  def find_n(index, shifts)
    if (index % 4).zero?
      shifts[0]
    elsif ((index - 1) % 4).zero?
      shifts[1]
    elsif ((index - 2) % 4).zero?
      shifts[2]
    else
      shifts[3]
    end
  end

  def shifts_from_codebreaker(message, codebreaker)
    last_four = message[-4..].chars
    base_shifts = []
    last_four.zip(codebreaker.chars) do |pair|
      encrypted = letters.find_index(pair[0])
      decrypted = letters.find_index(pair[1])
      base_shifts << encrypted - decrypted
    end
    shift_position = 4 - (message.length % 4)
    base_shifts.rotate(shift_position)
  end

  def find_key(shifts, date)
    offsets = shift_offsets(date)
    keys = find_shift_keys(shifts, offsets)
    keys[:A] + keys[:B][1] + keys[:C][1] + keys[:D][1]
  end

  def find_shift_keys(shifts, offsets)
    all_possible_keys = possible_keys_by_position(shifts, offsets)
    formatted_keys = all_possible_keys.map do |keys|
      keys.map { |key| key.to_s.rjust(2, '0') }
    end
    shift_keys = Hash.new('')
    formatted_keys[0].find do |key_a|
      shift_keys[:A] = key_a
      formatted_keys[1].find do |key_b|
        shift_keys[:B] = key_b
        formatted_keys[2].find do |key_c|
          shift_keys[:C] = key_c
          formatted_keys[3].find do |key_d|
            shift_keys[:D] = key_d
            key_a[1] == key_b[0] && key_b[1] == key_c[0] && key_c[1] == key_d[0]
          end
        end
      end
    end
    shift_keys
  end

  def possible_keys_by_position(shifts, offsets)
    base_keys = key_baselines(shifts, offsets)
    set = (0..100).to_a
    base_keys.map do |key|
      possible_keys = set.find_all do |num|
        num % 27 == key
      end
      if possible_keys.length.zero?
        [27]
      else
        possible_keys
      end
    end
  end

  def key_baselines(shifts, offsets)
    normalized_shifts = normalize(shifts)
    keys = []
    normalized_shifts.zip(offsets) do |pair|
      shift_key = pair[0] - pair[1]
      keys << shift_key
    end
    keys
  end

  def normalize(shifts)
    shifts.map do |shift|
      shift += 27 while shift.negative?
      shift -= 27 while shift > 27
      shift
    end
  end

  def get_shifts(key, date)
    keys = shift_keys(key)
    offsets = shift_offsets(date)
    final_shifts = []
    keys.zip(offsets) { |shift_key, offset| final_shifts << shift_key + offset }
    final_shifts
  end

  def shift_keys(key)
    digits = key.chars
    shift_keys = []
    digits.each_cons(2) { |pair| shift_keys << pair.join.to_i }
    shift_keys
  end

  def shift_offsets(date)
    date_squared = date.to_i**2
    digits = date_squared.to_s[-4..]
    digits.chars.map(&:to_i)
  end

  def letters
    ('a'..'z').to_a << ' '
  end
end
