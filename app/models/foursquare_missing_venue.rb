require 'foursquare2'

class FoursquareMissingVenue
  
  def name
    "default venue"
  end
  

    def categories
      icon    = Hashie::Mash.new(prefix: "https://ss3.4sqi.net/img/categories_v2/travel/busstation_", suffix: ".png")
      id      = ""
      name    = ""
      plural_name  = ""
      primary     = true
      short_name   = ""
      cat_hm = Hashie::Mash.new(icon: icon, id: id, 
        name: name, pluralName: plural_name, primary: primary, shortName: short_name)
    end
  
    def contact
      #contact=#<Hashie::Mash formattedPhone="(407) 939-7433" phone="4079397433"> 

      cat_contact = Hashie::Mash.new(formattedPhone: "(407) 939-7433", phone: "4079397433")
    end
    
    def hereNow
      #<Hashie::Mash count=0 groups=[] summary="Nobody here"> 
      cat_hereNow = Hashie::Mash.new(count: 0, groups: "4079397433", summary: "Nobody here")
    end
    
    def id
      id="4dd5d72de4cd37c8938591ea" 
    end
    
    def location
      # location=#<Hashie::Mash cc="US" city="Lake Buena Vista" country="United States" crossStreet="all over Walt Disney World" distance=182 formattedAddress=["all over Walt Disney World", "Lake Buena Vista, FL 32830", "United States"] lat=28.37852393229888 lng=-81.56662923700945 postalCode="32830" state="FL"> 
      formatted_address = ["all over Walt Disney World", "Lake Buena Vista, FL 32830", "United States"]
      
      cat_location = Hashie::Mash.new(cc: "US", 
        city: "Lake Buena Vista", 
        country:"United States", 
        crossStreet: "all over Walt Disney World", 
        distance: 182, 
        formattedAddress: formatted_address, 
        lat: 28.37852393229888, 
        lng: -81.56662923700945, 
        postalCode: "32830",
        state: "FL")
    end
    
    def referralId
      cat_referral_id = "v-1443540209" 
    end
    
    def specials
      #<Hashie::Mash count=0 items=[]> 
      cat_specials = Hashie::Mash.new(count: 0, items: [])
    end
    
    def stats
      #<Hashie::Mash checkinsCount=12294 tipCount=64 usersCount=6951> 
      cat_stats = Hashie::Mash.new(checkinsCount: 0, tipCount: 0, usersCount: 0)
    end
    
    def verified
      verified=false
    end
end