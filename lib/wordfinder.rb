require 'rubygems'
require 'sinatra'
require 'json'

WORDS = File.open("#{File.dirname(__FILE__)}/../words/sowpods.txt",'r') { |f| f.read.split("\r\n") }

# Finds words
#
# @param [Array] search_letters An array of letters to search
# @param [Fixnum] max_word_length the maximum word length to return
#
# Brute Force FTL
def find_words(words, search_letters, max_word_length = 8)
  words.select do |word| 
    if word.length > max_word_length
      false
    else
      letters = search_letters.clone
      word.chars.all? do |char|
        if pos = letters.index(char)
          letters.delete_at(pos)
          true
        else
          false
        end
      end
    end
  end.flatten.compact.sort {|a,b| a.length <=> b.length }
end

get '/' do
  "Words!"
end

post "/find" do
  unless letters = params[:letters]
    halt 500, "Letters Missing"
  end
  find_words(WORDS, letters.chars.map(&:upcase)).to_json
end
