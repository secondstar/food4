require 'foursquare2'

class Foursquare
  # Focused on only WDW venues
  attr_reader :params
  
  def initialize(params = {:client_id => FOURSQUARE_ID, 
        :client_secret  => FOURSQUARE_SECRET, 
        :api_version    => "220120609",
        :search_radius  => '6000',
        :center_lat     => '28.37777',
        :center_lng     => '-81.56498'
      }
        )
        @params = params
  end

  def title
    "i am foursquare"
  end
  
  def find_review(query = "")
    # if the eatery does not exist w/i WDW or the FoursquareBridge doesn't know it, you get nil value
    query                   = _get_foursquare_venue_name(query)
    review_search_results   = search_reviews(query).first[1]
    # review = review_search_results.first
    review  = _detect_desired_review(review_search_results, query)
    alternate_reviews = review_search_results#
    @alt_names = []
    alternate_reviews.each do |review|
      @alt_names << review.name
    end
    # @alt_names
    return [review, @alt_names]
  end
    
  def search_reviews(query = "")
    reviews = client.search_venues(:ll => "#{params[:center_lat]}, #{params[:center_lng]}", 
        :query => query, 
        :radius => params[:search_radius]
        )
    review = reviews
  end

  def yield_default_venue
    # venue = self.search_venues.first[1].first
    default_venue = search_reviews.first[1].first
    default_venue.name = "default venue"
    default_venue
  end
  
  def _detect_desired_review(review_search_results = search_reviews.first[1], query = "")
    review = review_search_results.detect {|v| v[:name] == query}
    
  end
  
  def _create_default_review(review_search_results)
    review = review_search_results.first
    review.name = "default venue"
    review
  end
  private
  
  def client
    client = Foursquare2::Client.new(:client_id => params[:client_id], 
        :client_secret => params[:client_secret], 
        :api_version => params[:api_version])
  end

  def _get_foursquare_venue_name(query = "")
    FoursquareBridge.new({:name=> query}).get_review_name
  end
  
end