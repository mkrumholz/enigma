class KeyBreaker
  def self.find_key(shifts, offsets)
    keys = find_shift_keys(shifts, offsets)
    keys[:A] + keys[:B][1] + keys[:C][1] + keys[:D][1]
  end

  def self.find_shift_keys(shifts, offsets)
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
      shift_key = pair[0] - pair[1]
      keys << shift_key
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
end
