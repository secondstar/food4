class DfbDomainKnowledge
  def initialize(photo_target="red")
    @photo_target = photo_target
  end

  ## This class is 1/2 of an attempt to isolate current and upcoming non-standard ##
  ## formats of the eatery reviews of disneyfoodblog.com                          ##
  ## The mess of working with DFB stay within this and the review scan classes.   ##
  # ! The methods and their contents will continue to change and adapt.!          ##
  
  def i_know_from_404
    # bad links from dfb's index {given_link:currently_correct_link}
    links_and_their_updated_links = {"el-pirata-y-el-perico" => "tortuga-tavern"}
  end
  
  def i_know_normal_scrape_does_not_work
    resulting_array = ["2010 09 30 First Look Epcots New Karamell Kuche", "2013 01 15 Review Epcots Les Halles Bakery", "2013 09 04 First Look Starbucks Opens At Epcots Fountain View Cafe", "2013 05 29 First Look Lartisan Des Glaces Sorbet And Ice Cream Shop In Epcots France Is Open See Full Menu And Photos Here", "Disney Bar And Lounge Menu", "2014 01 21 News And Review The Smokehouse At House Of Blues Opens In Downtown Disney", "Team Spirits Pool Bar", "El Pirata Y El Perico", "Yakitori House", "Http   Disneyfoodblog Com Monsieur Paul Restaurant", "Kouzzina", "Siestas Pool Par", "Aunt Pollys", "Be Our Guest Restaurant", "Tomorrowland Terrace Cafe", "Westward Ho Refreshments", "Bistro De Paris", "La Cava Del Tequila", "Nine Dragons Restaurant", "Rose And Crown Pub", "Tutto Gusto", "Dawa Bar", "Dino Bite Snacks", "Drinkwallah", "Gardens Kiosk", "Harambe Fruit Market", "High Octane Refreshments", "Tune In Lounge", "Atlantic Dance Hall", "Jellyrolls Dueling Piano Bar", "Queen Victorias Room At Victoria And Alberts Restaurant", "The Gurgling Suitcase", "Trader Sams Tiki Terrace", "Garden Gallery", "Manginos", "Trout Pass", "Dockside Margaritas", "Downtown Disney Food Trucks", "Crêpes de Chefs de France"]
  end
  
  def i_know_these_links_are_not_listed_on_site
    eatery_title_and_permalink = {"Hollywood Scoops" => "hollywood-scoops", 
      "Dinosaur Gertie’s Ice Cream of Extinction" => "dinosaur-gerties-ice-cream-of-extinction", 
      "Oasis Canteen" => "oasis-canteen",
      "Anaheim Produce" => "anaheim-produce", 
      "KRNR Rock Station" => "krnr-rock-station", 
      "Peevy’s Polar Pipeline" => "peevys-polar-pipeline", 
      "Sweet Spells" => "sweet-spells", 
      "Avalunch" => "avalunch", 
      "Cooling Hut" => "cooling-hut", 
      "Frostbite Freddy's" => "frostbite-freddys", 
      "Warming Hut" => "warming-hut",
      "Coffee Hut" => "coffee-hut", 
      "Contemporary Grounds" => "contemporary-grounds",
      "Meadow Snack Bar" => "meadow-snack-bar",
      "Chuck Wagon" => "chuck-wagon", 
      "Garden View Lounge Afternoon Tea" => "garden-view-tea-room",
      "Scat Cats Club" => "scat-cats-club", 
      "Scat Cats" => "scat-cats", 
      "Turf Club Lounge" => "turf-club-lounge",
      "Java Bar" => "java-bar", 
      "Splash Terrace" => "splash-terrace",
      "Big Top Treats" => "big-top-treats",
      "Tortuga Tavern"  => "tortuga-tavern",
      "Karamell-Küche"  => "karamell-kuche",
      "Les Halles Boulangerie Patisserie" => "les-halles-boulangerie-patisserie",
      "Fountain View" => "fountain-view",
      "L’Artisan des Glaces" => "lartisan-des-glaces",
      "The Smokehouse" => "the-smokehouse",
      "Grandstand Spirits Pool Bar" => "grandstand-spirits-pool-bar",
      "Katsura Grill" => "katsura-grill",
      "Yak and Yeti Local Foods Cafe" => "yak-and-yeti-counter-service",
      "Spice Road Table" => "spice-road-table",
      "Hey Howdy Hey Takeaway" => "hey-howdy-hey-takeaway"
      }
  end

  def i_know_these_links_have_bad_hash_keys
    permalinks = %w(turf-club
      trout-pass
      garden-grove-cafe
    victoria-and-alberts-restaurant
    gasparilla-grill-and-games
2013/05/29/first-look-lartisan-des-glaces-sorbet-and-ice-cream-shop-in-epcots-france-is-open-see-full-menu-and-photos-here
    2013/01/15/review-epcots-les-halles-bakery
    2013/09/04/first-look-starbucks-opens-at-epcots-fountain-view-cafe
    be-our-guest-restaurant
    shulas-steak-house
    artist-point
    gastons-tavern
    bistro-de-paris
    monsieur-paul-restaurant
    fresh-mediterranean-market
    bluezoo
    queen-victorias-room-at-victoria-and-alberts-restaurant
    backstretch-pool-bar
    il-mulino-new-york-trattoria
    kimonos-sushi-bar
    wolfgang-puck-express
    on-the-rocks-pool-bar
    monsieur-paul-restaurant
    cool-wash-pizza
    discovery-island-allergy-friendly-kiosk
    zuris-sweets-shop
    )
  end
end