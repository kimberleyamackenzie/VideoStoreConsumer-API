class MovieWrapper
  BASE_URL = "https://api.themoviedb.org/3/"
  KEY = ENV["TMDB_TOKEN"]

  BASE_IMG_URL = "https://image.tmdb.org/t/p/"
  DEFAULT_IMG_SIZE = "w185"
  DEFAULT_IMG_URL = "https://media1.popsugar-assets.com/files/thumbor/GZfL-TlNbcJwZWI13H10p1x45VM/fit-in/1024x1024/filters:format_auto-!!-:strip_icc-!!-/2016/07/28/836/n/1922283/623c3d55_edit_img_cover_file_28576183_1423177200/i/Saved-Bell-Where-Now.jpg"

  def self.search(query)
    url = BASE_URL + "search/movie?api_key=" + KEY + "&query=" + query
    # puts url
    response =  HTTParty.get(url)
    if response["total_results"] == 0
      return []
    else
      movies = response["results"].map do |result|
        self.construct_movie(result)
      end
      return movies
    end
  end

  private

  def self.construct_movie(api_result)
    Movie.new(
      title: api_result["title"],
      overview: api_result["overview"],
      release_date: api_result["release_date"],
      image_url: api_result["poster_path"], #(api_result["poster_path"] ? self.construct_image_url(api_result["poster_path"]) : nil),
      external_id: api_result["id"])
  end

  def self.construct_image_url(img_name)
    return BASE_IMG_URL + DEFAULT_IMG_SIZE + img_name
  end

end
