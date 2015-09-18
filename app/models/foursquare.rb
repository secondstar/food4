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
  
  def find_venue(query = "")
    query = _get_foursquare_venue_name(query)
    venue = search_venues(query).first[1].detect {|v| v[:name] == query}
  end
  
  def search_venues(query = "")
    params_ll = "#{params[:center_lat]}, #{params[:center_lng]}"
    venues = client.search_venues(:ll => params_ll, 
        :query => query, 
        :radius => params[:search_radius]
        )
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