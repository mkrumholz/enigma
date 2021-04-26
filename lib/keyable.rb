module Keyable
  def self.random_key
    value = (0..100_000).to_a.sample
    value.to_s.rjust(5, '0')
  end

  def self.date_today
    date = Date.today
    date.strftime('%d%m%y')
  end
end
