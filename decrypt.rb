require 'date'
require './lib/enigma'
require './lib/keyable'

enigma = Enigma.new

message = File.read(ARGV[0])

details = enigma.decrypt(message, ARGV[2], ARGV[3])

File.write(ARGV[1], details[:decryption])

p "Created '#{ARGV[1]}' with the key" +
  " #{details[:key]} and date #{details[:date]}"
