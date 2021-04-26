require './lib/keyable'

class Enigma
  include Keyable

  def encrypt(message, key = Keyable.random_key, date = Keyable.date_today)
    letter_indexes = convert_to_indexes(message)
    shifts = get_shifts(key, date)
    encrypted_indexes = update_by_index(letter_indexes, shifts)
    { encryption: convert_to_string(encrypted_indexes),
      key: key,
      date: date }
  end

  def decrypt(message, key, date = Keyable.date_today)
    letter_indexes = convert_to_indexes(message)
    shifts = get_shifts(key, date)
    decrypted_indexes = update_by_index(letter_indexes, shifts, -1)
    { decryption: convert_to_string(decrypted_indexes),
      key: key,
      date: date }
  end

  def crack(message, date = Keyable.date_today)
    codebreaker = ' end'
    shifts = shifts_from_codebreaker(message, codebreaker)
    offsets = shift_offsets(date)
    key = KeyBreaker.find_key(shifts, offsets)
    decrypt(message, key, date)
  end

  def update_by_index(letter_indexes, shifts, direction = 1)
    index = 0
    letter_indexes.map do |letter_index|
      n = find_n(index, shifts) * direction
      index += 1
      shift_by_n(letter_index, n)
    end
  end

  def shift_by_n(index, n)
    return index if index.is_a? String

    (index + n) % 27
  end

  def convert_to_indexes(message)
    message = message.downcase.chars
    message.map do |letter|
      letter = letters.find_index(letter) if letters.include?(letter)
      letter
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
    rotations = shift_rotations(message, codebreaker)
    base_shifts.rotate(rotations)
  end

  def shift_rotations(message, codebreaker)
    position = codebreaker.length
    position - (message.length % position)
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
