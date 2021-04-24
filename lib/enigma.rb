require './lib/keyable'

class Enigma
  include Keyable

  def encrypt(message, key = Keyable.random_key, date = Keyable.date_today)
    letter_indexes = convert_to_indexes(message)
    shifts = get_shifts(key, date)
    encrypted_indexes = encrypt_by_index(letter_indexes, shifts)
    encryption = convert_to_string(encrypted_indexes)
    format_encryption_hash(encryption, key, date)
  end

  def decrypt(message, key, date = Keyable.date_today)
    letter_indexes = convert_to_indexes(message)
    shifts = get_shifts(key, date)
    decrypted_indexes = decrypt_by_index(letter_indexes, shifts)
    decryption = convert_to_string(decrypted_indexes)
    format_decryption_hash(decryption, key, date)
  end

  def encrypt_by_index(letter_indexes, shifts)
    index = 0
    k = letter_indexes.map do |char_index|
      if char_index.is_a? String
        index += 1
        char_index
      else
        n = find_n(index, shifts)
        index += 1
        (char_index + n) % 27
      end
    end
  end

  def decrypt_by_index(letter_indexes, shifts)
    index = 0
    letter_indexes.map do |char_index|
      if char_index.is_a? String
        index += 1
        char_index
      else
        n = find_n(index, shifts)
        index += 1
        (char_index - n) % 27
      end
    end
  end

  def convert_to_indexes(message)
    message = message.downcase.chars
    message.map do |letter|
      if !letters.include?(letter)
        letter
      else
        letters.find_index(letter)
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

  def format_encryption_hash(encryption, key, date)
    encrypted_message = {}
    encrypted_message[:encryption] = encryption
    encrypted_message[:key] = key
    encrypted_message[:date] = date
    encrypted_message
  end

  def format_decryption_hash(decryption, key, date)
    decrypted_message = {}
    decrypted_message[:decryption] = decryption
    decrypted_message[:key] = key
    decrypted_message[:date] = date
    decrypted_message
  end
end
