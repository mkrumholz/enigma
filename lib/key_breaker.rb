class KeyBreaker
  def self.find_key(shifts, offsets)
    all_possible_keys = possible_keys_by_position(shifts, offsets)
    formatted_keys = all_possible_keys.map { |keys| format_keys(keys) }
    keys = find_true_keys(formatted_keys)
    keys[:A] + keys[:B][1] + keys[:C][1] + keys[:D][1]
  end

  def self.find_true_keys(possible_keys)
    shift_keys = Hash.new('')
    possible_keys[0].find do |key_a|
      shift_keys[:A] = key_a
      possible_keys[1].find do |key_b|
        shift_keys[:B] = key_b
        possible_keys[2].find do |key_c|
          shift_keys[:C] = key_c
          possible_keys[3].find do |key_d|
            shift_keys[:D] = key_d
            key_a[1] == key_b[0] && key_b[1] == key_c[0] && key_c[1] == key_d[0]
          end
        end
      end
    end
    shift_keys
  end

  def self.possible_keys_by_position(shifts, offsets)
    base_keys = key_baselines(shifts, offsets)
    set = (0..100).to_a
    base_keys.map do |key|
      set.find_all do |num|
        key % 27 == num % 27
      end
    end
  end

  def self.key_baselines(shifts, offsets)
    normalized_shifts = normalize(shifts)
    keys = []
    normalized_shifts.zip(offsets) do |pair|
      keys << pair[0] - pair[1]
    end
    keys
  end

  def self.normalize(shifts)
    shifts.map do |shift|
      shift += 27 while shift.negative?
      shift -= 27 while shift > 27
      shift
    end
  end

  def self.format_keys(keys)
    keys.map { |key| key.to_s.rjust(2, '0') }
  end
end
