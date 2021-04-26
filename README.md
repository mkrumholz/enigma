# Enigma

## Description

Enigma is my final solo project for Module 1 of the [Backend program](https://backend.turing.edu/) for the [Turing School of Software and Design](https://turing.edu/). Inspired by Alan Turing's [invention of the "Bombe"](https://www.iwm.org.uk/history/how-alan-turing-cracked-the-enigma-code) during WWII, which cracked the "Enigma" code used by Germany, Enigma creates CLIs that allow a user to encrypt messages using a series of letter shifts. Enigma can also decrypt encrypted messages using a key and date and can crack the encryption code using just the message and date transmitted to decrypt messages for which no key is given.

## Self-Assessment

This project will be assessed based on 5 basic categories. Below are self-assessments for my project in each.

### Functionality

`Enigma` can crack codes! All CLIs have been implemented (encryption, decryption, code-cracking). Given more time for the project, I would have liked to be able to better handle edge cases, such as providing better error messages prompting a user who, for example, inputs the wrong number of arguments for one of my runner files. However, I believe that based on the spec given, I have implemented all required and optional functionality.

### Object-Oriented Programming

I have implemented one module, `Keyable`, which completes `Enigma`'s optional inputs (necessary for using the key) when those are not provided. I created a module here since it will be called several times throughout `Enigma` and could, in a future case, also be used to help prompt users for proper inputs or generate inputs in the runner files. Its methods are independent of the `Enigma` class, so it could be used in other situations, which made a module seem like the proper choice here.

I did not use inheritance in this project, as there was no logical situation where I needed 3+ classes to inherit behaviors from a parent class.

I struggled a bit with deciding how to implement the `KeyBreaker` class. Ultimately, I decided that functionality, finding the key based on the information given (message and date-based offsets), should live outside of `Enigma` to comply with the SRP. `Enigma` is only responsible for converting between encrypted and decrypted messages, while the `KeyBreaker` is responsible for finding the key for cracking codes. This class is coupled with `Enigma` and is only called once. Though it is independently functional, it's difficult to see another separate use-case for this, so I decided to make it a class, rather than a module.

### Ruby Conventions and Mechanics

A good deal of thought was put into naming conventions through the project and I used Rubocop to help ensure consistent styling. I configured some of Rubocop's settings to conform with my preferred styles. I have one method longer than 10 lines in the `KeyBreaker`, which I was not able to refactor into separate methods or more concise code. All other complex methods were refactored in an effort to keep each method's functionality to just one responsibility.

### Test Driven Development

I used stubs to test the methods from `Keyable`. One of those methods relies on random number generation, so a stub was used to avoid randomness (`#sample`). The other relies on a date that will shift based on when the method is called (`#today`), so this was also stubbed to ensure that the test suite would not 'expire.' Stubbing these methods allowed me to test the `Keyable` module more robustly. I also stubbed the `Keyable` methods `#random_key` and `#date_today`) for testing `Enigma`, which also enabled me to test different input scenarios for `Enigma` without relying on functionality from `Keyable`, therefore making `Enigma`'s tests more independent.

SimpleCov shows test coverage at 100.00%:

<img width="1084" alt="simplecov_final" src="https://user-images.githubusercontent.com/26797256/116156591-ed3f5780-a6a8-11eb-9d64-7631c5063663.png">

### Version Control

Overall, I am pleased with my git/GitHub workflow. The project has 100+ commits over 9 pull requests. I used GitHub's project tracker to help organize chunks of effort into Issues and Milestones, which I completed in sequence.
