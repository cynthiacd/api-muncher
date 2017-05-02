require 'test_helper'

describe EdamamSearch do

  describe 'initialize' do

  end

  describe 'search_results' do
    it 'gets results from Edamam' do
      VCR.use_cassette("search_results") do
        search_input = EdamamSearch.new("duck")
        response = search_input.search_results
        response.count.must_be :>, 0
      end
    end

    it 'raises returns count 0 there are no results' do
      VCR.use_cassette("search_results") do
        search_input = EdamamSearch.new("dafjkaljdaklj")
        response = search_input.search_results
        response["count"].must_equal 0
      end
    end

    it 'returns ? when there are no results' do

    end
  end
end
