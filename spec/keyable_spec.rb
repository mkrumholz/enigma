require './lib/keyable'

describe Keyable do
  describe '#random_key' do
    it 'returns a random 5 digit key' do
      key = Keyable.random_key

      expect(key).is_a? String
      expect(key.length).to eq 5
      expect(key.to_i).to be_between(0, 100_000).exclusive
    end

    it 'l-pads 0s for numbers below 10000' do
      allow_any_instance_of(Array).to receive(:sample) { 15 }
      key = Keyable.random_key

      expect(key).to eq '00015'
    end
  end

  describe '#date_today' do
    it 'returns the date formatted as a string' do
      key = Keyable.date_today

      expect(key).is_a? String
      expect(key.length).to eq 6
    end

    it 'properly formats a date' do
      allow(Date).to receive(:today) { Date.parse('2021-04-23') }
      key = Keyable.date_today

      expect(key).to eq '042321'
    end
  end
end
