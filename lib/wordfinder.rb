require 'rubygems'
require 'sinatra'
require 'json'

WORDS = File.open("#{File.dirname(__FILE__)}/../words/sowpods.txt",'r') { |f| f.read.split("\r\n") }

def find_words_for(search_letters)
  WORDS.select do |word| 
    letters = search_letters.clone
    word.chars.all? do |char|
      if pos = letters.index(char)
        letters.delete_at(pos)
        true
      else
        false
      end
    end
  end.flatten.compact.sort {|a,b| a.length <=> b.length }.select {|w| w.length <= 8 }
end

get '/' do
  "Words!"
end

post "/find" do
  unless letters = params[:letters]
    halt 500, "Letters Missing"
  end
  find_words_for(letters.chars.map(&:upcase)).to_json
end
