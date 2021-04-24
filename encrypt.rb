require 'date'
require './lib/enigma'
require './lib/keyable'

enigma = Enigma.new

message = File.read(ARGV[0])

details = enigma.encrypt(message)

File.write(ARGV[1], details[:encryption])

p "Created '#{ARGV[1]}' with the key #{details[:key]} and date #{details[:date]}"
