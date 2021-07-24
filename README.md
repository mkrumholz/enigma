# Enigma

## Description

Inspired by Alan Turing's [invention of the "Bombe"](https://www.iwm.org.uk/history/how-alan-turing-cracked-the-enigma-code) during WWII, which cracked the "Enigma" code used by Germany, Enigma creates CLIs that allow a user to encrypt messages using a series of letter shifts. Enigma can also decrypt encrypted messages using a key and date and can crack the encryption code using just the message and date transmitted to decrypt messages for which no key is given.

Enigma was my final solo project for Module 1 of the [Backend program](https://backend.turing.edu/) for the [Turing School of Software and Design](https://turing.edu/).

## Installation & Usage

1. Fork and clone the repo
2. Navigate to the root directory
4. To encrypt text:

    a. Find or create a `.txt` file (or use the provided `decrpyted.txt`)
    
    b. Create a file where you'd like to store the encrypted text
    
    c. Run: `$ ruby ./lib/encrypt.rb unencrypted_file_name.txt encrypted.txt`
    
    d. This will return a message stating something like: `Created 'encrypted.txt' with the key 82648 and date 240818`
    
    e. Check the encrypted text file to see the encrypted message!
    
5. To decrypt text:

    a. OPTION 1 - decrypt with the key and date:
    
    
      * You'll need your encrypted file, a file to store your decrypted message, the 5-digit key, and 6-digit date from your encryption.

      * Run: `$ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 240818`

      * Check the updated text file to see the decrypted message!
      
        
    b. OPTION 2 - crack the code without knowing the key:
    
    
      * You'll still need the two files: the encrypted text file and a file to store the decrypted message.

      * You'll also need the 6-digit date on which the message was encrypted.

      * Run: `$ ruby ./lib/crack.rb encrypted.txt cracked.txt 240818`

      * Check the updated text file to see the decrypted message!

## Testing

A TDD approach was used for all parts of the build process. SimpleCov test coverage is at 100.00%:

<img width="500" alt="simplecov_final" src="https://user-images.githubusercontent.com/26797256/116156591-ed3f5780-a6a8-11eb-9d64-7631c5063663.png">
