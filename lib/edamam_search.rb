require 'httparty'
class EdamamSearch
  class EdamamException < RuntimeError
  end

  BASE_URL = "https://api.edamam.com/search?"

  attr_reader :search_text, :results

  def initialize(search_info)
    @search_text = search_info
    # health = search_hash[:health_options]
    # diet = search_hash[:diet_options]
  end

  def search_results
    query_params = {
                    "app_id" => ENV["EDAMAM_ID"],
                    "app_key" => ENV["EDAMAM_KEY"],
                    "q" => @search_text
                    # "Diet" => "",
                    # "Health" => ""
                   }

    # response = HTTParty.get("https://api.edamam.com/search?app_id=#{ENV["EDAMAM_ID"]}&app_key=#{ENV["EDAMAM_KEY"]}&q=#{@search_text}")
    url = "#{BASE_URL}"
    response = HTTParty.get(url, query: query_params)
    if response["count"] > 0
      return labels_and_images(response)
    elsif response["count"] == 0
      return "Sorry there are no results for that search"
    else
      raise EdamamException.new(response["error"])
    end
  end

private

  def labels_and_images(response)
    results = response["hits"].map do |info|
      recipe = Hash.new
      recipe[:uri] = info["recipe"]["uri"]
      recipe[:label] = info["recipe"]["label"]
      recipe[:image_url] = info["recipe"]["image"]
      recipe
    end
    return results
  end

end