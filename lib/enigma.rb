class Enigma
  def encrypt(message, key, date)
    letter_indexes = convert_to_indexes(message)
    shifts = get_shifts(key, date)
    encrypted_indexes = encrypt_by_index(letter_indexes, shifts)
    convert_to_string(encrypted_indexes)
  end

  def encrypt_by_index(letter_indexes, shifts)
    index = 0
    letter_indexes.map do |char_index|
      n = find_n(index, shifts)
      index += 1
      (char_index + n) % 27
    end
  end

  def convert_to_indexes(message)
    message = message.chars
    message.map do |letter|
      letters.find_index(letter)
    end
  end

  def convert_to_string(index_array)
    index_array.map do |index|
      letters[index]
    end.join
  end

  def find_n(index, shifts)
    if index.zero? || (index % 4).zero?
      shifts[0]
    elsif index == 1 || ((index - 1) % 4).zero?
      shifts[1]
    elsif index == 2 || ((index - 2) % 4).zero?
      shifts[2]
    else
      shifts[3]
    end
  end

  # method for generating random 5-digit, zero-padded #s
  # method for generating random date and converting to string

  def get_shifts(key, date)
    keys = shift_keys(key)
    offsets = shift_offsets(date)
    final_shifts = []
    keys.zip(offsets) { |key, offset| final_shifts << key + offset }
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
