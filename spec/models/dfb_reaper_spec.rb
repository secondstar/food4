# require 'minitest/autorun'
require_relative '../spec_helper_lite'
require File.expand_path('../../../config/environment', __FILE__)
require_relative '../../app/models/dfb_reaper'
require "ostruct"

describe DfbReaper do
  let(:url) { "http://www.disneyfoodblog.com/disney-world-restaurants-guide"}
    
  subject { DfbReaper.reap_review_names_permalinks }
    
  it "works" do
    subject.must_equal [{"Aloha Isle"=>"aloha-isle", "Auntie Gravitys Galactic Goodies"=>"auntie-gravitys-galactic-goodies", "Aunt Pollys"=>"aunt-pollys", "Be Our Guest Restaurant"=>"be-our-guest-restaurant", "Caseys Corner"=>"caseys-corner", "Cheshire Cafe"=>"cheshire-cafe", "Cinderellas Royal Table"=>"cinderellas-royal-table", "Columbia Harbor House"=>"columbia-harbor-house", "Cosmic Rays Starlight Cafe"=>"cosmic-rays-starlight-cafe", "Crystal Palace"=>"crystal-palace", "Diamond Horseshoe"=>"diamond-horseshoe", "Friars Nook"=>"friars-nook", "Gastons Tavern"=>"gastons-tavern", "Golden Oak Outpost"=>"golden-oak-outpost", "Liberty Square Market"=>"liberty-square-market", "Liberty Tree Tavern"=>"liberty-tree-tavern", "The Lunching Pad"=>"the-lunching-pad", "Main Street Bakery"=>"main-street-bakery", "Main Street Ice Cream Parlor"=>"main-street-ice-cream-parlor", "Pecos Bills Tall Tale Inn And Cafe"=>"pecos-bills-tall-tale-inn-and-cafe", "Pinocchios Village Haus"=>"pinocchios-village-haus", "The Plaza Restaurant"=>"the-plaza-restaurant", "Sleepy Hollow"=>"sleepy-hollow", "Storybook Treats"=>"storybook-treats", "Sunshine Tree Terrace"=>"sunshine-tree-terrace", "Tomorrowland Terrace Cafe"=>"tomorrowland-terrace-cafe", "Tomorrowland Terrace Restaurant"=>"tomorrowland-terrace-restaurant", "Tonys Town Square"=>"tonys-town-square", "El Pirata Y El Perico"=>"el-pirata-y-el-perico", "Westward Ho Refreshments"=>"westward-ho-refreshments", "Cool Wash Pizza"=>"cool-wash-pizza", "Electric Umbrella"=>"electric-umbrella", "2013 09 04 First Look Starbucks Opens At Epcots Fountain View Cafe"=>"2013/09/04/first-look-starbucks-opens-at-epcots-fountain-view-cafe", "Sunshine Seasons"=>"sunshine-seasons", "Coral Reef Restaurant"=>"coral-reef-restaurant", "Garden Grill Restaurant"=>"garden-grill-restaurant", "Akershus Royal Banquet Hall Princess Storybook Restaurant"=>"akershus-royal-banquet-hall-princess-storybook-restaurant", "Biergarten Restaurant"=>"biergarten-restaurant", "Bistro De Paris"=>"bistro-de-paris", "2013 01 15 Review Epcots Les Halles Bakery"=>"2013/01/15/review-epcots-les-halles-bakery", "Chefs De France"=>"chefs-de-france", "Fife And Drum Tavern"=>"fife-and-drum-tavern", "2010 09 30 First Look Epcots New Karamell Kuche"=>"2010/09/30/first-look-epcots-new-karamell-kuche", "Yakitori House"=>"yakitori-house", "Kringla Bakeri Og Cafe"=>"kringla-bakeri-og-cafe", "2013 05 29 First Look Lartisan Des Glaces Sorbet And Ice Cream Shop In Epcots France Is Open See Full Menu And Photos Here"=>"2013/05/29/first-look-lartisan-des-glaces-sorbet-and-ice-cream-shop-in-epcots-france-is-open-see-full-menu-and-photos-here", "La Cantina De San Angel"=>"la-cantina-de-san-angel", "La Cava Del Tequila"=>"la-cava-del-tequila", "Le Cellier Steakhouse"=>"le-cellier-steakhouse", "La Hacienda De San Angel"=>"la-hacienda-de-san-angel", "Liberty Inn"=>"liberty-inn", "Lotus Blossom Cafe"=>"lotus-blossom-cafe", "Http   Disneyfoodblog Com Monsieur Paul Restaurant"=>"http://disneyfoodblog.com/monsieur-paul-restaurant", "Nine Dragons Restaurant"=>"nine-dragons-restaurant", "Promenade Refreshments"=>"promenade-refreshments", "Refreshment Cool Post"=>"refreshment-cool-post", "Refreshment Port"=>"refreshment-port", "Restaurant Marrakesh"=>"restaurant-marrakesh", "Rose And Crown Pub And Dining Room"=>"rose-and-crown-pub-and-dining-room", "San Angel Inn Restaurante"=>"san-angel-inn-restaurante", "Sommerfest"=>"sommerfest", "Tangierine Cafe"=>"tangierine-cafe", "Teppan Edo Restaurant"=>"teppan-edo-restaurant", "Tokyo Dining"=>"tokyo-dining", "Tutto Italia Ristorante"=>"tutto-italia-ristorante", "Tutto Gusto"=>"tutto-gusto", "Via Napoli"=>"via-napoli", "Yorkshire County Fish Shop"=>"yorkshire-county-fish-shop", "Beastly Kiosk"=>"beastly-kiosk", "Dawa Bar"=>"dawa-bar", "Dino Bite Snacks"=>"dino-bite-snacks", "Dino Diner"=>"dino-diner", "Flame Tree Barbecue"=>"flame-tree-barbecue", "Gardens Kiosk"=>"gardens-kiosk", "Harambe Fruit Market"=>"harambe-fruit-market", "Kusafiri Coffee Shop And Bakery"=>"kusafiri-coffee-shop-and-bakery", "Mr Kamals"=>"mr-kamals", "Pizzafari"=>"pizzafari", "Rainforest Cafe"=>"rainforest-cafe", "Restaurantosaurus"=>"restaurantosaurus", "Tamu Tamu Refreshments"=>"tamu-tamu-refreshments", "Tusker House Restaurant"=>"tusker-house-restaurant", "Yak And Yeti Counter Service"=>"yak-and-yeti-counter-service", "Yak And Yeti Restaurant"=>"yak-and-yeti-restaurant", "50s Prime Time Cafe"=>"50s-prime-time-cafe", "Abc Commissary"=>"abc-commissary", "Backlot Express"=>"backlot-express", "Hollywood Brown Derby"=>"hollywood-brown-derby", "Catalina Eddies"=>"catalina-eddies", "Fairfax Fare"=>"fairfax-fare", "Herbies Drive In"=>"herbies-drive-in", "High Octane Refreshments"=>"high-octane-refreshments", "Hollywood And Vine Restaurant"=>"hollywood-and-vine-restaurant", "Mama Melroses Ristorante Italiano"=>"mama-melroses-ristorante-italiano", "Min And Bills Dockside Diner"=>"min-and-bills-dockside-diner", "Rosies All American Cafe"=>"rosies-all-american-cafe", "Sci Fi Dine In Restaurant"=>"sci-fi-dine-in-restaurant", "Starring Rolls Cafe"=>"starring-rolls-cafe", "Studio Catering Co"=>"studio-catering-co", "Toluca Legs Turkey Co"=>"toluca-legs-turkey-co", "Toy Story Pizza Planet"=>"toy-story-pizza-planet", "Tune In Lounge"=>"tune-in-lounge", "Writers Stop"=>"writers-stop", "Disney Bar And Lounge Menu"=>"disney-bar-and-lounge-menu", "Silver Screen Spirits Pool Bar"=>"silver-screen-spirits-pool-bar", "World Premiere Food Court"=>"world-premiere-food-court", "Intermission Food Court"=>"intermission-food-court", "Singing Spirits Pool Bar"=>"singing-spirits-pool-bar", "End Zone Food Court"=>"end-zone-food-court", "Team Spirits Pool Bar"=>"team-spirits-pool-bar", "Boma"=>"boma", "Jiko"=>"jiko", "Maji Pool Bar"=>"maji-pool-bar", "Mara"=>"mara", "Sanaa"=>"sanaa", "Uzima Springs Pool Bar"=>"uzima-springs-pool-bar", "Victoria Falls"=>"victoria-falls", "The Drop Off Pool Bar"=>"the-drop-off-pool-bar", "Landscape Of Flavors"=>"landscape-of-flavors", "Beaches And Cream"=>"beaches-and-cream", "Cape May Cafe"=>"cape-may-cafe", "Hurricane Hannas"=>"hurricane-hannas", "Marthas Vineyard Lounge"=>"marthas-vineyard-lounge", "Atlantic Dance Hall"=>"atlantic-dance-hall", "Belle Vue Lounge"=>"belle-vue-lounge", "Big River Grille And Brewing Works"=>"big-river-grille-and-brewing-works", "Boardwalk Bakery"=>"boardwalk-bakery", "Boardwalk Joes"=>"boardwalk-joes", "Boardwalk Pizza Window"=>"boardwalk-pizza-window", "Espn Club"=>"espn-club", "Flying Fish Cafe"=>"flying-fish-cafe", "Jellyrolls Dueling Piano Bar"=>"jellyrolls-dueling-piano-bar", "Kouzzina"=>"kouzzina", "Leaping Horse Libations"=>"leaping-horse-libations", "Banana Cabana Pool Bar"=>"banana-cabana-pool-bar", "Old Port Royale Food Court"=>"old-port-royale-food-court", "Shutters At Old Port Royale"=>"shutters-at-old-port-royale", "California Grill"=>"california-grill", "California Grill Lounge"=>"california-grill-lounge", "Chef Mickeys"=>"chef-mickeys", "Contempo Cafe"=>"contempo-cafe", "Cove Bar"=>"cove-bar", "Outer Rim"=>"outer-rim", "Sand Bar"=>"sand-bar", "Top Of The World Lounge"=>"top-of-the-world-lounge", "The Wave"=>"the-wave", "Cafe Rix"=>"cafe-rix", "Laguna Pool Bar"=>"laguna-pool-bar", "Maya Grill"=>"maya-grill", "Pepper Market Food Court"=>"pepper-market-food-court", "Rix Lounge"=>"rix-lounge", "Siestas Pool Par"=>"siestas-pool-par", "Cabana Bar And Beach Club"=>"cabana-bar-and-beach-club", "Fresh Mediterranean Market"=>"fresh-mediterranean-market", "The Fountain"=>"the-fountain", "Picabu Buffeteria"=>"picabu-buffeteria", "Shulas Steak House"=>"shulas-steak-house", "Bluezoo"=>"bluezoo", "Crocketts Tavern"=>"crocketts-tavern", "Hoop Dee Doo Revue"=>"hoop-dee-doo-revue", "Mickeys Backyard Bbq"=>"mickeys-backyard-bbq", "Trails End Restaurant"=>"trails-end-restaurant", "1900 Park Fare"=>"1900-park-fare", "Beach Pool Bar"=>"beach-pool-bar", "Citricos"=>"citricos", "Gasparilla Grill And Games"=>"gasparilla-grill-and-games", "Grand Floridian Cafe"=>"grand-floridian-cafe", "Mizners Lounge"=>"mizners-lounge", "Narcoossees"=>"narcoossees", "St Johns Pool Bar"=>"st-johns-pool-bar", "Victoria And Alberts Restaurant"=>"victoria-and-alberts-restaurant", "Queen Victorias Room At Victoria And Alberts Restaurant"=>"queen-victorias-room-at-victoria-and-alberts-restaurant", "Goods Food To Go"=>"goods-food-to-go", "The Gurgling Suitcase"=>"the-gurgling-suitcase", "Olivias Cafe"=>"olivias-cafe", "Turtle Shack"=>"turtle-shack", "Barefoot Pool Bar"=>"barefoot-pool-bar", "Captain Cooks Snack Company"=>"captain-cooks-snack-company", "Kona Cafe"=>"kona-cafe", "Kona Island Sushi Bar"=>"kona-island-sushi-bar", "Ohana"=>"ohana", "Spirit Of Aloha Dinner Show"=>"spirit-of-aloha-dinner-show", "Tambu Lounge"=>"tambu-lounge", "Everything Pop Food Court"=>"everything-pop-food-court", "Petals Pool Bar"=>"petals-pool-bar", "Mardi Grogs Pool Bar"=>"mardi-grogs-pool-bar", "Sassagoula Floatworks And Food Factory"=>"sassagoula-floatworks-and-food-factory", "Scat Cats"=>"scat-cats", "Boatwrights"=>"boatwrights", "River Roost Lounge"=>"river-roost-lounge", "Riverside Mill Food Court"=>"riverside-mill-food-court", "Artists Palette"=>"artists-palette", "Backstretch Pool Bar"=>"backstretch-pool-bar", "On The Rocks Pool Bar"=>"on-the-rocks-pool-bar", "Paddock Grill"=>"paddock-grill", "Turf Club"=>"turf-club", "Garden Gallery"=>"garden-gallery", "Manginos"=>"manginos", "Garden Grove Cafe"=>"garden-grove-cafe", "Il Mulino New York Trattoria"=>"il-mulino-new-york-trattoria", "Kimonos Sushi Bar"=>"kimonos-sushi-bar", "Artist Point"=>"artist-point", "Roaring Fork"=>"roaring-fork", "Territory Lounge"=>"territory-lounge", "Trout Pass"=>"trout-pass", "Whispering Canyon Cafe"=>"whispering-canyon-cafe", "Ale Compass Lounge"=>"ale-compass-lounge", "The Crews Cup Lounge"=>"the-crews-cup-lounge", "Captains Grille"=>"captains-grille", "Yachtsman Steakhouse"=>"yachtsman-steakhouse", "Earl Of Sandwich"=>"earl-of-sandwich", "Fultons Crab House"=>"fultons-crab-house", "Ghirardelli Soda Fountain"=>"ghirardelli-soda-fountain", "T Rex"=>"t-rex", "Wolfgang Puck Express"=>"wolfgang-puck-express", "Cookes Of Dublin"=>"cookes-of-dublin", "Paradiso 37"=>"paradiso-37", "Planet Hollywood"=>"planet-hollywood", "Portobello Restaurant"=>"portobello-restaurant", "Raglan Road"=>"raglan-road", "Amc Dine In Theater"=>"amc-dine-in-theater", "Bongos"=>"bongos", "House Of Blues"=>"house-of-blues", "2014 01 21 News And Review The Smokehouse At House Of Blues Opens In Downtown Disney"=>"2014/01/21/news-and-review-the-smokehouse-at-house-of-blues-opens-in-downtown-disney", "Splitsville Luxury Lanes"=>"splitsville-luxury-lanes", "Wolfgang Puck Cafe"=>"wolfgang-puck-cafe", "Lottawatta Lodge"=>"lottawatta-lodge", "Leaning Palms"=>"leaning-palms", "Typhoon Tillys"=>"typhoon-tillys"}]
  end

  describe "scan_review_details" do
    let(:permalink) {"aloha-isle"}
    
    subject { DfbReaper.scan_review_details}
    
    it "works" do
      subject.must_equal [{"service"=>"Counter Service", "type_of_food"=>"Dole Whip, soft-serve ice cream, fruit", "location"=>"Adventureland, Magic Kingdom", "disney_dining_plan"=>"Yes, snack credits", "tables_in_wonderland"=>"No", "menu"=>"<br>\n<a href=\"https://disneyworld.disney.go.com/dining/magic-kingdom/aloha-isle/menus/\" target=\"_blank\">Official Disney Menu</a>", "important_info"=>"", "famous_dishes"=>"Pineapple Dole Whip, Pineapple Dole Whip Float", "mentioned_in"=>""}]
    end
  end
end