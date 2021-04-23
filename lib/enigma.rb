class Enigma

  def encrpyt(message, key, date)

    # use ("a".."z").to_a << " " for array
    #   new_array = []
    #   each_with_index { |letter, index| new_array << index }
    #   this gets us the array of numbers
    # create shifts array
    # use shifts cyclically to use index of letter (orig) to calculate
    # index of letter encrypted
    # add that letter to the final string


  end

  # method for generating random 5-digit, zero-padded #s

  def shift_keys(key)
    digits = key.split("")
    shift_keys = []
    digits.each_cons(2) do |pair|
      shift_keys << pair.join.to_i
    end
    shift_keys
  end

  # method for finding shift Offsets
    # find the shift Offsets
    # num = (date.to_i^^2).to_s/a take [-5 thru -1]
    # A shift += num[0]
    # B shift += num[1]
    # etc.
  def shift_offsets(date)
    date_squared = date.to_i**2
    digits = date_squared.to_s[-4..-1]
    digits.split("").map { |digit| digit.to_i }
  end

  # method for calculating shifts
    # sum the two arrays


end
