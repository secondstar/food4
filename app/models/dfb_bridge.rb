class DfbBridge
  #names of the eateries and lodgings on DFB do not exactly match touringplans
  # target should be an OpenStruct containing {permalink: "akershus-royal-banquet-hall"}
  attr_reader :target
  
  def initialize(target)
    @target = target
  end
  
  def get_review_permalink
    # will return known dfb permalink, or original permalink
    ch = dfb_name_conversion_hash
    result = ch.fetch(target[:permalink], target[:permalink])
  end
  
  def get_eatery_permalink
    # will return known dfb permalink, or original permalink
    d2ch = dfb_to_eatery_conversion_hash
    result = d2ch.fetch(target[:permalink], target[:permalink])
    
  end
  
  def dfb_to_eatery_conversion_hash
    conversion_hash =
        {"akershus-royal-banquet-hall-princess-storybook-restaurant" => "akershus-royal-banquet-hall",
          "the-lunching-pad" => "lunching-pad",
          "beaches-and-cream" => "beaches-cream",
		      "biergarten-restaurant" => "biergarten",
			    "big-river-grille-and-brewing-works" => "big-river-grille-brewing-works",
				"bluezoo" => "todd-english-blue-zoo",
				"boatwrights" => "boatwrights-dining-hall",
				"boma" => "boma-flavors-of-africa",
				"columbia-harbor-house" => "columbia-harbour-house",
				"el-pirata-y-el-perico" => "tortuga-tavern",
				"electric-umbrella" => "electric-umbrella-restaurant",
        "studio-catering-co" => "studio-catering-company",
				"hollywood-and-vine-restaurant" => "hollywood-and-vine",
				"il-mulino-new-york-trattoria" => "ii-mulino-new-york-trattoria",
				"jiko" => "jiko-the-cooking-place",
				"kimonos-sushi-bar" => "kimonos",
				"kouzzina" => "kouzzina-by-cat-cora",
				"kringla-bakeri-og-cafe" => "kringla-bakeri-og-kafe",
				"pecos-bills-tall-tale-inn-and-cafe" => "pecos-bill-tall-tale-inn-and-cafe",
				"pinocchios-village-haus" => "pinocchio-village-haus",
				"rainforest-cafe" => "rainforest-cafe-animal-kingdom",
				"rose-and-crown-pub-and-dining-room" => "rose-and-crown-dining-room",
				"rose-and-crown-pub-and-dining-room" => "rose-and-crown-pub",
				"san-angel-inn-restaurante" => "san-angel-inn",
				"sci-fi-dine-in-restaurant" => "scifi-dine-in-theater-restaurant",
				"sleepy-hollow" => "sleepy-hollow-refreshments",
				"teppan-edo-restaurant" => "teppan-edo",
				"the-lunching-pad" => "lunching-pad",
				"the-plaza-restaurant" => "plaza-restaurant",
				"tonys-town-square" => "tonys-town-square-restaurant",
				"turf-club" => "turf-club-bar-grill",
        "victoria-and-alberts-restaurant" => "victoria-alberts",
				"yak-and-yeti-counter-service" => "yak-and-yeti-local-food-cafe",
				"yak-and-yeti-restaurant" => "yak-yeti-restaurant",
        "victoria-falls" => "victoria-falls-lounge",
        "the-drop-off-pool-bar" => "the-drop-off",
        "beaches-and-cream" => "beaches-cream-soda-shop",
        "hurricane-hannas" => "hurricane-hannas-grill",
        "banana-cabana-pool-bar" => "banana-cabana",
        "the-wave" => "the-wave-restaurant",
        "outer-rim" => "outer-rim-lounge",
        "top-of-the-world-lounge" => "top-world-lounge",
        "pepper-market-food-court" => "pepper-market",
        "siestas-pool-par" => "siestas-cantina",
        "beach-pool-bar" => "beaches-pool-bar-grill",
        "gasparilla-grill-and-games" => "gasparilla-grill-games",
        "st-johns-pool-bar" => "courtyard-pool-bar",
        "captain-cooks-snack-company" => "captain-cooks",
        "kona-island-sushi-bar" => "kona-island",
        "sassagoula-floatworks-and-food-factory" => "sassagoula-floatworks-food-factory",
        "mardi-grogs-pool-bar" => "mardi-grogs",
        "on-the-rocks-pool-bar" => "on-rocks",
        "the-crews-cup-lounge" => "crews-cup-lounge",
        "the-fountain" => "fountain-eats-sweets",
        "picabu-buffeteria" => "picabu",
        "cabana-bar-and-beach-club" => "cabana-bar-beach-club",
        "garden-grove-cafe" => "garden-grove",
        "ghirardelli-soda-fountain" => "ghirardelli-soda-fountain-chocolate-shop",
        "rainforest-cafe" => "rainforest-cafe-downtown-disney",
        "wolfgang-puck-express" => "wolfgang-puck-express-marketplace",
        "rainforest-cafe" => "rainforest-cafe-downtown-disney",
        "portobello-restaurant" => "portobello",
        "raglan-road" => "raglan-road-irish-pub-restaurant",
        "amc-dine-in-theater" => "amc-dine-in-theatres-fork-screen",
        "bongos" => "bongos-cuban-cafe",
        "splitsville-luxury-lanes" => "splitsville",
        "wolfgang-puck-cafe" => "wolfgang-puck-dining-room",
        "wolfgang-puck-express" => "wolfgang-puck-express-west-side",
        "tamu-tamu-refreshments" => "tamu-tamu",
        "main-street-ice-cream-parlor" => "plaza-ice-cream-parlor"
      }
  end
  def dfb_name_conversion_hash
    conversion_hash = {
        "akershus-royal-banquet-hall" => "akershus-royal-banquet-hall-princess-storybook-restaurant" ,
        "beaches-cream" => "beaches-and-cream",
        "biergarten" => "biergarten-restaurant",
        "big-river-grille-brewing-works" => "big-river-grille-and-brewing-works",
        "bluezoo" => "todd-english-blue-zoo",
        "disneys-boardwalk-inn" => "boardwalk-bakery",
        "disneys-boardwalk-inn" => "boardwalk-pizza-window",
        "boatwrights-dining-hall" => "boatwrights",
        "boma-flavors-of-africa" => "boma",
        "electric-umbrella-restaurant" => "electric-umbrella",
        "studio-catering-company" => "studio-catering-co",
        "hollywood-and-vine" => "hollywood-and-vine-restaurant",
        "ii-mulino-new-york-trattoria" => "il-mulino-new-york-trattoria",
        "jiko-the-cooking-place" => "jiko",
        "kimonos-sushi-bar" => "kimonos",
        "kouzzina-by-cat-cora" => "kouzzina",
        "kringla-bakeri-og-kafe" => "kringla-bakeri-og-cafe",
        "pecos-bill-tall-tale-inn-and-cafe" => "pecos-bills-tall-tale-inn-and-cafe",
        "pinocchio-village-haus"=> "pinocchios-village-haus",
        "rainforest-cafe-animal-kingdom" => "rainforest-cafe",
        "rose-and-crown-dining-room" => "rose-and-crown-pub-and-dining-room",
        "san-angel-inn" => "san-angel-inn-restaurante",
        "scifi-dine-in-theater-restaurant"=> "sci-fi-dine-in-restaurant",
        "sleepy-hollow-refreshments" => "sleepy-hollow",
        "teppan-edo" => "teppan-edo-restaurant",
        "lunching-pad" => "the-lunching-pad",
        "plaza-restaurant" => "the-plaza-restaurant",
        "tonys-town-square-restaurant" => "tonys-town-square",
        "turf-club-bar-grill" => "turf-club",
        "victoria-alberts" => "victoria-and-alberts-restaurant",
        "yak-and-yeti-local-food-cafe" => "yak-and-yeti-counter-service",
        "yak-yeti-restaurant" => "yak-and-yeti-restaurant",
        "columbia-harbour-house" => "columbia-harbor-house",
        "victoria-falls-lounge" => "victoria-falls",
        "the-drop-off-pool-bar" => "the-drop-off",
        "beaches-and-cream-soda-shop" => "beaches-cream",
        "hurricane-hannas-grill" => "hurricane-hannas",
        "banana-cabana" => "banana-cabana-pool-bar",
        "the-wave-restaurant" => "the-wave",
        "outer-rim" => "outer-rim-lounge",
        "top-world-lounge" => "top-of-the-world-lounge",
        "pepper-market" => "pepper-market-food-court",
        "siestas-cantina" => "siestas-pool-par",
        "beach-pool-bar-bar-grill" => "beaches-pool",
        "gasparilla-grill-and-games" => "gasparilla-grill-and-games",
        "courtyard-pool-bar" => "st-johns-pool-bar",
        "captain-cooks" => "captain-cooks-snack-company",
        "kona-island" => "kona-island-sushi-bar",
        "sassagoula-floatworks-food-factory" => "sassagoula-floatworks-and-food-factory",
        "mardi-grogs" => "mardi-grogs-pool-bar",
        "on-rocks" => "on-the-rocks-pool-bar",
        "the-crews-cup-lounge" => "crews-cup-lounge",
        "fountain-eats-sweets" => "the-fountain",
        "picabu" =>  "picabu-buffeteria",
        "cabana-bar-beach-club" => "cabana-bar-and-beach-club",
        "garden-grove" => "garden-grove-cafe",
        "ghirardelli-soda-fountain-chocolate-shop" => "ghirardelli-soda-fountain",
        "rainforest-cafe-downtown-disney" => "rainforest-cafe",
        "wolfgang-puck-express-marketplace" => "wolfgang-puck-express",
        "rainforest-cafe-downtown-disney" => "rainforest-cafe",
        "portobello" => "portobello-restaurant",
        "raglan-road-irish-pub-restaurant" => "raglan-road",
        "amc-dine-in-theatres-fork-screen" =>"amc-dine-in-theater",
        "bongos-cuban-cafe" => "bongos",
        "splitsville" => "splitsville-luxury-lanes",
        "wolfgang-puck-dining-room" => "wolfgang-puck-cafe",
         "wolfgang-puck-express-west-side" => "wolfgang-puck-express",
         "tamu-tamu" => "tamu-tamu-refreshments",
         "plaza-ice-cream-parlor" => "main-street-ice-cream-parlor"
         
      }
    

  end
  
  def map_dfb
    
  @belongings_array = [
    {"eatery_permalink" => "akershus-royal-banquet-hall-princess-storybook-restaurant","parent_permalink" => "akershus-royal-banquet-hall","parent_type" => "Eatery"},
  {"eatery_permalink" => "artists-palette","parent_permalink" => "disneys-saratoga-springs-resort-spa","parent_type" => "District"},
  {"eatery_permalink" => "aunt-pollys","parent_permalink" => "magic-kingdom","parent_type" => "District"},
  {"eatery_permalink" => "auntie-gravitys-galactic-goodies","parent_permalink" => "magic-kingdom","parent_type" => "District"},
  {"eatery_permalink" => "beaches-and-cream","parent_permalink" => "beaches-cream","parent_type" => "Eatery"},
  {"eatery_permalink" => "biergarten-restaurant","parent_permalink" => "biergarten","parent_type" => "Eatery"},
  {"eatery_permalink" => "big-river-grille-and-brewing-works","parent_permalink" => "big-river-grille-brewing-works","parent_type" => "Eatery"},
  {"eatery_permalink" => "bluezoo","parent_permalink" => "todd-english-blue-zoo","parent_type" => "Eatery"},
  {"eatery_permalink" => "boardwalk-bakery","parent_permalink" => "disneys-boardwalk-inn","parent_type" => "District"},
  {"eatery_permalink" => "boardwalk-pizza-window","parent_permalink" => "disneys-boardwalk-inn","parent_type" => "District"},
  {"eatery_permalink" => "boatwrights","parent_permalink" => "boatwrights-dining-hall","parent_type" => "Eatery"},
  {"eatery_permalink" => "boma","parent_permalink" => "boma-flavors-of-africa","parent_type" => "Eatery"},
  {"eatery_permalink" => "bongos","parent_permalink" => "downtown-disney","parent_type" => "District"},
  {"eatery_permalink" => "cabana-bar-and-beach-club","parent_permalink" => "dolphin-at-walt-disney-world","parent_type" => "District"},
  {"eatery_permalink" => "capn-jacks-restaurant","parent_permalink" => "downtown-disney","parent_type" => "District"},
  {"eatery_permalink" => "captain-cooks-snack-company","parent_permalink" => "disneys-polynesian-resort","parent_type" => "District"},
  {"eatery_permalink" => "chefs-de-france","parent_permalink" => "epcot","parent_type" => "District"},
  {"eatery_permalink" => "columbia-harbor-house","parent_permalink" => "columbia-harbour-house","parent_type" => "Eatery"},
  {"eatery_permalink" => "cookes-of-dublin","parent_permalink" => "downtown-disney","parent_type" => "District"},
  {"eatery_permalink" => "cool-wash-pizza","parent_permalink" => "epcot","parent_type" => "District"},
  {"eatery_permalink" => "cove-bar","parent_permalink" => "bay-lake-tower-at-disneys-contemporary-resort","parent_type" => "District"},
  {"eatery_permalink" => "crocketts-tavern","parent_permalink" => "fort-wilderness-resort-cabins","parent_type" => "District"},
  {"eatery_permalink" => "dino-bite-snacks","parent_permalink" => "animal-kingdom","parent_type" => "District"},
  {"eatery_permalink" => "disney-bar-and-lounge-menu","parent_permalink" => "swan-at-walt-disney-world","parent_type" => "District"},
  {"eatery_permalink" => "earl-of-sandwich","parent_permalink" => "downtown-disney","parent_type" => "District"},
  {"eatery_permalink" => "el-pirata-y-el-perico","parent_permalink" => "tortuga-tavern","parent_type" => "Eatery"},
  {"eatery_permalink" => "electric-umbrella","parent_permalink" => "electric-umbrella-restaurant","parent_type" => "Eatery"},
  {"eatery_permalink" => "end-zone-food-court","parent_permalink" => "disneys-all-star-sports-resort","parent_type" => "District"},
  {"eatery_permalink" => "everything-pop-food-court","parent_permalink" => "disneys-pop-century-resort","parent_type" => "District"},
  {"eatery_permalink" => "fultons-crab-house","parent_permalink" => "downtown-disney","parent_type" => "District"},
  {"eatery_permalink" => "garden-gallery","parent_permalink" => "shades-of-green-at-walt-disney-world","parent_type" => "District"},
  {"eatery_permalink" => "gasparilla-grill-and-games","parent_permalink" => "disneys-grand-floridian-resort","parent_type" => "District"},
  {"eatery_permalink" => "goods-food-to-go","parent_permalink" => "disneys-old-key-west-resort","parent_type" => "District"},
  {"eatery_permalink" => "hollywood-and-vine-restaurant","parent_permalink" => "hollywood-and-vine","parent_type" => "Eatery"},
  {"eatery_permalink" => "house-of-blues","parent_permalink" => "downtown-disney","parent_type" => "District"},
  {"eatery_permalink" => "hurricane-hannas","parent_permalink" => "disneys-yacht-club-resort","parent_type" => "District"},
  {"eatery_permalink" => "il-mulino-new-york-trattoria","parent_permalink" => "ii-mulino-new-york-trattoria","parent_type" => "Eatery"},
  {"eatery_permalink" => "intermission-food-court","parent_permalink" => "disneys-all-star-music-resort","parent_type" => "District"},
  {"eatery_permalink" => "jiko","parent_permalink" => "jiko-the-cooking-place","parent_type" => "Eatery"},
  {"eatery_permalink" => "kimonos-sushi-bar","parent_permalink" => "kimonos","parent_type" => "Eatery"},
  {"eatery_permalink" => "kona-island-sushi-bar","parent_permalink" => "disneys-polynesian-resort","parent_type" => "District"},
  {"eatery_permalink" => "kouzzina","parent_permalink" => "kouzzina-by-cat-cora","parent_type" => "Eatery"},
  {"eatery_permalink" => "kringla-bakeri-og-cafe","parent_permalink" => "kringla-bakeri-og-kafe","parent_type" => "Eatery"},
  {"eatery_permalink" => "la-cava-del-tequila","parent_permalink" => "epcot","parent_type" => "District"},
  {"eatery_permalink" => "main-street-bakery","parent_permalink" => "magic-kingdom","parent_type" => "District"},
  {"eatery_permalink" => "main-street-ice-cream-parlor","parent_permalink" => "magic-kingdom","parent_type" => "District"},
  {"eatery_permalink" => "manginos","parent_permalink" => "animal-kingdom","parent_type" => "District"},
  {"eatery_permalink" => "ohana","parent_permalink" => "ohanas","parent_type" => "Eatery"},
  {"eatery_permalink" => "old-port-royale-food-court","parent_permalink" => "disneys-caribbean-beach-resort","parent_type" => "District"},
  {"eatery_permalink" => "paradiso-37","parent_permalink" => "downtown-disney","parent_type" => "District"},
  {"eatery_permalink" => "pecos-bills-tall-tale-inn-and-cafe","parent_permalink" => "pecos-bill-tall-tale-inn-and-cafe","parent_type" => "Eatery"},
  {"eatery_permalink" => "pepper-market-food-court","parent_permalink" => "disneys-coronado-springs-resort","parent_type" => "District"},
  {"eatery_permalink" => "picabu-buffeteria","parent_permalink" => "dolphin-at-walt-disney-world","parent_type" => "District"},
  {"eatery_permalink" => "pinocchios-village-haus","parent_permalink" => "pinocchio-village-haus","parent_type" => "Eatery"},
  {"eatery_permalink" => "planet-hollywood","parent_permalink" => "downtown-disney","parent_type" => "District"},
  {"eatery_permalink" => "pollo-campero","parent_permalink" => "downtown-disney","parent_type" => "District"},
  {"eatery_permalink" => "portobello-restaurant","parent_permalink" => "downtown-disney","parent_type" => "District"},
  {"eatery_permalink" => "queen-victorias-room-at-victoria-and-alberts-restaurant","parent_permalink" => "disneys-grand-floridian-resort","parent_type" => "District"},
  {"eatery_permalink" => "raglan-road","parent_permalink" => "downtown-disney","parent_type" => "District"},
  {"eatery_permalink" => "rainforest-cafe","parent_permalink" => "rainforest-cafe-animal-kingdom","parent_type" => "Eatery"},
  {"eatery_permalink" => "riverside-mill-food-court","parent_permalink" => "disneys-port-orleans-resort-riverside","parent_type" => "District"},
  {"eatery_permalink" => "roaring-fork","parent_permalink" => "disneys-wilderness-lodge","parent_type" => "District"},
  {"eatery_permalink" => "rose-and-crown-pub-and-dining-room","parent_permalink" => "rose-and-crown-dining-room","parent_type" => "Eatery"},
  {"eatery_permalink" => "rose-and-crown-pub-and-dining-room","parent_permalink" => "rose-and-crown-pub","parent_type" => "Eatery"},
  {"eatery_permalink" => "san-angel-inn-restaurante","parent_permalink" => "san-angel-inn","parent_type" => "Eatery"},
  {"eatery_permalink" => "sand-bar","parent_permalink" => "disneys-contemporary-resort","parent_type" => "District"},
  {"eatery_permalink" => "sassagoula-floatworks-and-food-factory","parent_permalink" => "disneys-port-orleans-resort-french-quarter","parent_type" => "District"},
  {"eatery_permalink" => "sci-fi-dine-in-restaurant","parent_permalink" => "scifi-dine-in-theater-restaurant","parent_type" => "Eatery"},
  {"eatery_permalink" => "sleepy-hollow","parent_permalink" => "sleepy-hollow-refreshments","parent_type" => "Eatery"},
  {"eatery_permalink" => "t-rex","parent_permalink" => "downtown-disney","parent_type" => "District"},
  {"eatery_permalink" => "teppan-edo-restaurant","parent_permalink" => "teppan-edo","parent_type" => "Eatery"},
  {"eatery_permalink" => "the-lunching-pad","parent_permalink" => "lunching-pad","parent_type" => "Eatery"},
  {"eatery_permalink" => "the-plaza-restaurant","parent_permalink" => "plaza-restaurant","parent_type" => "Eatery"},
  {"eatery_permalink" => "the-wave","parent_permalink" => "disneys-contemporary-resort","parent_type" => "District"},
  {"eatery_permalink" => "tonys-town-square","parent_permalink" => "tonys-town-square-restaurant","parent_type" => "Eatery"},
  {"eatery_permalink" => "turf-club","parent_permalink" => "turf-club-bar-grill","parent_type" => "Eatery"},
  {"eatery_permalink" => "turtle-shack","parent_permalink" => "disneys-old-key-west-resort","parent_type" => "District"},
  #
  {"eatery_permalink" => "victoria-and-alberts-restaurant","parent_permalink" => "victoria-alberts","parent_type" => "Eatery"},
  {"eatery_permalink" => "wolfgang-puck-cafe","parent_permalink" => "downtown-disney","parent_type" => "District"},
  {"eatery_permalink" => "wolfgang-puck-express","parent_permalink" => "downtown-disney","parent_type" => "District"},
  {"eatery_permalink" => "world-premiere-food-court","parent_permalink" => "disneys-all-star-movies-resort","parent_type" => "District"},
  {"eatery_permalink" => "writers-stop","parent_permalink" => "hollywood-studios","parent_type" => "District"},
  {"eatery_permalink" => "yak-and-yeti-counter-service","parent_permalink" => "yak-and-yeti-local-food-cafe","parent_type" => "Eatery"},
  {"eatery_permalink" => "yak-and-yeti-restaurant","parent_permalink" => "yak-yeti-restaurant","parent_type" => "Eatery"}]
  end
  
  
end