require './lib/wordfinder'
require 'minitest/autorun'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

class WordFinderTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_says_words
    get '/'
    assert last_response.ok?
    assert_equal last_response.body, 'Words!'
  end

  def test_it_returns_500
    post '/find'
    assert last_response.status == 500
    assert_equal last_response.body, 'Letters Missing'
  end

  def test_it_finds_words
    post '/find', :letters => 'ame'
    assert last_response.ok?
    assert_equal last_response.body, "[\"AE\",\"AM\",\"EA\",\"ME\",\"MA\",\"EM\",\"MAE\"]"
  end
end
