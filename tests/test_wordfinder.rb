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
    assert_match "Find Words!", last_response.body
  end

  def test_it_returns_500
    post '/find'
    assert last_response.status == 500
    assert_equal 'Letters Missing', last_response.body
  end

  def test_it_finds_words
    post '/find', :letters => 'ame'
    assert last_response.ok?
    assert_equal "[\"AE\",\"AM\",\"EA\",\"ME\",\"MA\",\"EM\",\"MAE\"]", last_response.body
  end

  def test_finding_and_length
    post '/find', :letters => 'ame', :length => 2
    assert last_response.ok?
    assert_equal "[\"AE\",\"AM\",\"EA\",\"EM\",\"MA\",\"ME\"]", last_response.body, last_response.body.inspect
  end

end
