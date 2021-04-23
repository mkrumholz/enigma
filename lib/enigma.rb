class Enigma

  def encrypt(message, key, date)
    message_indexes = convert_to_indexes(message)
    shifts = get_shifts(key, date)
    index = 0
    encrypted_indexes = message_indexes.map do |char_index|
      n = find_n(index, shifts)
      index += 1
      ( char_index + n ) % 27
    end
    # encrypted_message = encrypted_indexes.map do |index|
    #   letters[index]
    # end.join
    convert_to_string(encrypted_indexes)
  end

  def convert_to_indexes(message)
    message = message.split('')
    message.map do |letter|
      letters.find_index(letter)
    end
  end

  def convert_to_string(index_array)
    index_array.map do |index|
      letters[index]
    end.join
  end

  def letters
    ("a".."z").to_a << " "
  end

  def find_n(index, shifts)
    if index == 0 || index % 4 == 0
      n = shifts[0]
    elsif index == 1 || (index - 1) % 4 == 0
      n = shifts[1]
    elsif index == 2 || (index - 2) % 4 == 0
      n = shifts[2]
    else
      n = shifts[3]
    end
  end

  # method for generating random 5-digit, zero-padded #s
  # method for generating random date and converting to string

  def get_shifts(key, date)
    keys = shift_keys(key)
    offsets = shift_offsets(date)
    final_shifts = []
    keys.zip(offsets) do |key, offset|
      final_shifts << key + offset
    end
    final_shifts
  end

  def shift_keys(key)
    digits = key.split("")
    shift_keys = []
    digits.each_cons(2) do |pair|
      shift_keys << pair.join.to_i
    end
    shift_keys
  end

  def shift_offsets(date)
    date_squared = date.to_i**2
    digits = date_squared.to_s[-4..-1]
    digits.split("").map { |digit| digit.to_i }
  end
end
