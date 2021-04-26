require 'date'
require './lib/enigma'
require './lib/keyable'
require './lib/key_breaker'

enigma = Enigma.new

message = File.read(ARGV[0])

details = if ARGV[2].nil?
            enigma.crack(message)
          else
            enigma.crack(message, ARGV[2])
          end

File.write(ARGV[1], details[:decryption])

p "Created '#{ARGV[1]}' with the cracked key" \
  " #{details[:key]} and date #{details[:date]}"
