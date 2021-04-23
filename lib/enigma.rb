class Enigma

  def encrypt(message, key, date)

    # use ("a".."z").to_a << " " for array
    #   new_array = []
    #   each_with_index { |letter, index| new_array << index }
    #   this gets us the array of numbers
    # get_shifts(key, date)
    # use shifts cyclically to use index of letter (orig) to calculate
    # index of letter encrypted
    # add that letter to the final string
    letters = ("a".."z").to_a << " "
    shifts = get_shifts(key, date)
    initial = message.split('')
    char_indexes = initial.map do |char|
      letters.find_index(char)
    end
    index = 0
    encrypted_indexes = char_indexes.map do |char_index|
      if index == 0 || index % 4 == 0
        n = shifts[0]
      elsif index == 1 || (index - 1) % 4 == 0
        n = shifts[1]
      elsif index == 2 || (index - 2) % 4 == 0
        n = shifts[2]
      else
        n = shifts[3]
      end
      index += 1
      ( char_index + n ) % 27
    end
    encrypted_message = encrypted_indexes.map do |index|
      letters[index]
    end.join
  end

  # method for generating random 5-digit, zero-padded #s
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
