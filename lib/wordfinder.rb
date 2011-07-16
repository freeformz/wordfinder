require 'rubygems'
require 'sinatra'
require 'json'

WORDS = File.open("#{File.dirname(__FILE__)}/../words/sowpods.txt",'r') { |f| f.read.split("\r\n") }

# Is the word contained in the letters?
#
# @param [String] word The word to check for
# @param [Array] letters capitalized letters to search
#
# Brute Force FTL
def word_contained_in_letters?(word, letters)
  word.chars.all? do |char|
    if pos = letters.index(char)
      letters.delete_at(pos)
      true
    else
      false
    end
  end
end

# Finds words in the search_letters from a dictionary
#
# @param [Array] words capitalized words array. The dictionary
# @param [Array] search_letters an array of capitalized letters to search
# @param [Fixnum] max_word_length the maximum word length to return
#
def find_words(words, search_letters, max_word_length)
  words.select do |word| 
    if word.length > max_word_length
      false
    else
      word_contained_in_letters?(word, search_letters.clone)
    end
  end.flatten.compact.sort {|a,b| a.length <=> b.length }
end

get '/' do
  <<EOF
Words!
EOF
end

post "/find" do
  unless letters = params[:letters]
    halt 500, "Letters Missing"
  end
  length = params[:length] ? params[:length].to_i : 8
  find_words(WORDS, letters.chars.map(&:upcase), length).to_json
end
