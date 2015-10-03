class FoursquareBridge
  #names of the eateries and lodgings on Foursquare do not exactly match touringplans
  # target should be an OpenStruct containing {permalink: "akershus-royal-banquet-hall"}
  attr_reader :target
  
  def initialize(target)
    @target = target
  end
  
  def title
    "now is the time"
  end
  
  def get_review_name
    #enter the name wdwhub knows as the name for the venue and return the name foursquare.com knows
    # "Cheshire Café"
    name = target[:name]
    _eatery_to_foursquare_conversion_hash.fetch(name, name)
  end
  
  def _eatery_to_foursquare_conversion_hash
    conversion_hash =
        {"Cheshire Cafe" => "Cheshire Café", 
          "Les Halles Boulangerie & Pâtisserie" => "Les Halles Boulangerie Patisserie",
          "Via Napoli Ristorante e Pizzeria"    => "Via Napoli",
          "Big Top Treats"                      => "Big Top Souvenirs",
          "Sleepy Hollow Refreshments"          => "Sleepy Hollow",
          "Cosmic Ray's Starlight Cafe"         => "Cosmic Ray's Starlight Café",
          "Main Street Bakery"                  => "Main Street Bakery (ft Starbucks)",
          "Pecos Bill Tall Tale Inn and Cafe"   => "Pecos Bill Tall Tale Inn & Café",
          "L’Artisan des Glaces Artisan Ice Cream & Sorbet" => "L’Artisan des Glaces Sorbet and Ice Cream Shop",
          "Kringla Bakeri og Kafe"              => "Kringla Bakeri Og Kafe",
          "Tutto Italia Ristorante"             => "Tutto Italia",
          "Chefs de France"                     => "Les Chefs de France",
          "San Angel Inn Restaurante"           => "San Angel Inn Restaurant",
          "Tangierine Cafe"                     => "Tangierine Café",
          "Refreshment Port"                    => "The Refreshment Port",
          "The Garden Grill"                    => "The Garden Grill Restaurant",
          "Karamell-Küche"                      => "Karamell Kuche",
          "La Cantina de San Angel"             => "La Cantina De San Angel",
          "Rose & Crown Dining Room"            => "The Rose & Crown Pub & Dining Room",
          "Fountain View"                       => "Fountain View (ft. Starbucks)",
          "Refreshment Cool Post"               => "Refreshment Coolpost",
          "Fantasmic Food Offerings"            => "Fantasmic Food And Beverage",
          "Writer's Stop"                       => "The Writer's Stop",
          "Hey Howdy Hey Take-away"             => "Hey Howdy Hey! Take Away",
          "Rosie's All-American Cafe"           => "Rosie's All American Cafe",
          "Sci-Fi Dine-In Theater Restaurant"   => "Sci-Fi Dine-In Theater",
          "The Trolley Car Cafe"                => "The Trolley Car Café (ft Starbucks)",
          "Muppets Joffrey's"                   => "JCT Co Service Station (Joffrey's Coffee)",
          "Toluca Legs Turkey Co."              => "Toluca Legs Turkey Co",
          "Sweet Spells"                        => "Beverly Sunset Sweet Spells",
          "Frostbite Freddy's"                  => "Frostbite Freddy's Frozen Freshments",
          "Crush Hot Dog Cart"                  => "Crush 'n' Gusher Hot Dog Cart",
          "Raglan Road Irish Pub & Restaurant"  => "Raglan Road Irish Pub",
          "The Dining Room at Wolfgang Puck Grande Cafe" => "The Dining Room at Wolfgang Puck Grand Cafe",
          "Haagen Dazs Marketplace"             => "Häagen-Dazs",
          "Forty Thirst Street-Marketplace"     => "Forty Thirst Street Express",
          "T-REX"                               => "T-Rex Cafe",
          "Starbucks Coffee - Downtown Disney West Side" => "Disney Springs West Side",
          "Bongos Cuban Café Express"           => "Bongo's Cuban Cafe",
          "Paradiso 37"                         => "Paradiso 37, Taste of the Americas",
          "Wolfgang Puck Express-West Side"     => "Wolfgang Puck Express (West Side)",
          "AMC Dine-In Theatres Fork & Screen"  => "AMC Downtown Disney 24",
          "Bongos Cuban Café"                   => "Bongo's Cuban Cafe",
          "Crossroads at House of Blues - Walt Disney World"    => "Crossroads At House Of Blues",
          "Haagen Dazs Westside"                => "Häagen-Dazs",
          "BabyCakes NYC"                       => "Erin McKenna's Bakery NYC",
          "Wolfgang Puck Express-Marketplace"   => "Wolfgang Puck Express (Marketplace)",
          "Cookes of Dublin"                    => "Cookes Of Dublin",
          "Vivoli Gelateria"                    => "Vivoli Il Gelato",
          "Ghirardelli Soda Fountain & Chocolate Shop " => "Ghirardelli Soda Fountain & Chocolate Shop",
          "Candy Cauldron"                      => "Disney's Candy Cauldron",
          "Wolfgang Puck Grand Café"            => "Wolfgang Puck Grand Cafe",
          "Il Mulino"                           => "Il Mulino New York Trattoria",
          "Garden Grove"                        => "Garden Grove Cafe",
          "Silver Screen Spirits Bar"           => "Silver Screen Spirits Pool Bar",
          "Singing Spirits Bar"                 => "Singing Spirits Pool Bar",
          "Team Spirits Bar"                    => "Grandstand Spirits Pool Bar",
          "Grandstand Spirits Bar"              => "Grandstand Spirits Pool Bar",
          "Uzima Springs Pool Bar"              => "Uzima Springs Watering Hole",
          "Victoria Falls Lounge"               => "Victoria Falls",
          "Boma - Flavors of Africa"            => "Boma Flavors of Africa",
          "Beaches & Cream To Go"               => "Beaches & Cream Soda Shop",
          "Beach Club Marketplace"              => "Beach Club Marketplace Food & Gifts",
          "Hurricane Hanna's Grill"             => "Hurricane Hanna's Grille",
          "Flying Fish Cafe"                    => "Flying Fish Café",
          "BoardWalk Pizza Window"              => "Pizza Window",
          "Shutters at Old Port Royale"         => "Shutters",
          "The Sand Bar"                        => "Sand Bar",
          "The Wave... of American Flavors"     => "The Wave of American Flavors",
          "Laguna Pool Bar"                     => "Laguna Bar",
          "Cafe Rix"                            => "Café Rix",
          "Scat Cat's Club"                     => "Scat Cat's Lounge",
          "Grand Floridian Cafe"                => "Grand Floridian Café",
          "Beaches Pool Bar & Grill"            => "Beaches Pool Bar and Grill",
          "Cabana Bar and Beach Club"           => "Cabana Bar & Grill",
          "Todd English's bluezoo"              => "Todd English's BlueZoo",
          "The Turf Club Bar and Grill"         => "Turf Club Bar and Grill",
          "Capt. Cook's"                        => "Captain Cook's",
          "Shula's Steak House"                 => "Shula's Steakhouse",
          "Disney's Spirit of Aloha Dinner Show" => "Spirit of Aloha Dinner Show",
          "Kona Cafe"                           => "Kona Café",
          "Whispering Canyon Cafe"              => "Whispering Canyon Café",
          "The Fountain Eats and Sweets"        => "The Fountain Eats & Sweets",
          "Hoop-Dee-Doo Musical Revue"          => "Hoop Dee Doo Musical Revue",
          "On the Rocks"                        => "On The Rocks",
          "Ale and Compass Lounge"              => "Ale & Compass Lounge",
          "Old Port Royale Food Court"          => "Old Port Royale, Old Port Royale Bus Stop",
          "Everything POP Shopping and Dining"  => "Everything Pop Shopping & Dining",
          "Olivia's Cafe"                       => "Olivia's Café",
          "Turtle Shack"                        => "Turtle Shack Poolside Snacks",
          
        }
  end
end