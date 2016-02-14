#!/usr/bin/env ruby
# encoding: UTF-8

def rand_string(length = 20)
  # Define range of values
  letters = ('a'..'z')
  numbers = (0..9)
  symbols = '! # $ % & = ~ * [ ] { } < > ( ) ^ @ + - _ . , ; : / ? |'.split(/\s/)
  
  # Declare the result variable
  result = Array.new
  
  # Expand ranges to arrays with the splat operator
  # Suffle the values in the array
  chars = [*letters,*letters.map(&:upcase),*numbers,*symbols].to_a.shuffle!
  
  # Create a string with the given length
  length.to_i.times do
    result.push(chars.fetch(rand(chars.length)))
  end
  
  # Return the generated string
  result.shuffle!.join
end