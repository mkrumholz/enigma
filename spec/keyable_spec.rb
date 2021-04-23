require './lib/random_key'

describe Keyable do
  describe '#random_key' do
    it 'returns a random 5 digit key' do
      key = Keyable.random_key

      expect(key).is_a? String
      expect(key.length).to eq 5
      expect(key.to_i).to be_between(0, 100_000).exclusive
    end

    # need to test that it zero-pads to the left (lpad)

    # it 'returns expected 5 digit key' do
    #   key = Keyable.random_key
    #
    #   expect(key.length).to eq 5
    #   expect(key).to be_between(0, 100_000).exclusive
    # end
  end
end
