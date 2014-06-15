require 'minitest/autorun'
require_relative '../../app/models/world_harvester'
require 'ostruct'

describe WorldHarvester do
  describe "find_park_eateries_list_by_permalink" do
    let(:district) {
        OpenStruct.new(:publish_on => Date.new(2012, 3, 7),
        :xyz_category_prefix => 'abc',
        :kind => 'magic_unicorn',
        :personal? => false,
        :match => 1337,
        :name => "Magic Kingdom")
      }
    
    
    subject { WorldHarvester.find_park_eateries_list_by_permalink(district.name) }
  
    it "works" do
      subject.must_equal [[{"name"=>"Aloha Isle", "permalink"=>"aloha-isle"}, 
        {"name"=>"Auntie Gravity's Galactic Goodies", "permalink"=>"auntie-gravitys-galactic-goodies"}, 
        {"name"=>"Big Top Treats", "permalink"=>"big-top-treats"}, 
        {"name"=>"Casey's Corner", "permalink"=>"caseys-corner"}, 
        {"name"=>"Cheshire Cafe", "permalink"=>"cheshire-cafe"}, 
        {"name"=>"Columbia Harbour House", "permalink"=>"columbia-harbour-house"}, 
        {"name"=>"Cosmic Ray's Starlight Cafe", "permalink"=>"cosmic-rays-starlight-cafe"}, 
        {"name"=>"Gaston's Tavern", "permalink"=>"gastons-tavern"}, 
        {"name"=>"Golden Oak Outpost", "permalink"=>"golden-oak-outpost"}, 
        {"name"=>"Liberty Square Market", "permalink"=>"liberty-square-market"}, 
        {"name"=>"Main Street Bakery", "permalink"=>"main-street-bakery"}, 
        {"name"=>"Pecos Bill Tall Tale Inn and Cafe", "permalink"=>"pecos-bill-tall-tale-inn-and-cafe"}, 
        {"name"=>"Pinocchio Village Haus", "permalink"=>"pinocchio-village-haus"}, 
        {"name"=>"Plaza Ice Cream Parlor", "permalink"=>"plaza-ice-cream-parlor"}, 
        {"name"=>"Sleepy Hollow Refreshments", "permalink"=>"sleepy-hollow-refreshments"}, 
        {"name"=>"Storybook Treats", "permalink"=>"storybook-treats"}, 
        {"name"=>"Sunshine Tree Terrace", "permalink"=>"sunshine-tree-terrace"}, 
        {"name"=>"The Diamond Horseshoe", "permalink"=>"diamond-horseshoe"}, 
        {"name"=>"The Friar's Nook", "permalink"=>"friars-nook"}, 
        {"name"=>"The Lunching Pad", "permalink"=>"lunching-pad"}, 
        {"name"=>"Tomorrowland Terrace Restaurant", "permalink"=>"tomorrowland-terrace"}, 
        {"name"=>"Tortuga Tavern", "permalink"=>"tortuga-tavern"}], 
        [{"name"=>"Be Our Guest Restaurant", "permalink"=>"be-our-guest"}, 
          {"name"=>"Cinderella's Royal Table", "permalink"=>"cinderellas-royal-table"}, 
          {"name"=>"Liberty Tree Tavern", "permalink"=>"liberty-tree-tavern"}, 
          {"name"=>"The Crystal Palace", "permalink"=>"crystal-palace"}, 
          {"name"=>"The Plaza Restaurant", "permalink"=>"plaza-restaurant"}, 
          {"name"=>"Tony's Town Square Restaurant", "permalink"=>"tonys-town-square-restaurant"}
        ]]
    end
  end
  
  
  describe "find_list_of_lodging_districts" do
    subject { WorldHarvester.find_list_of_lodging_districts }
    
    it "works" do
      subject.must_equal [{"name"=>"Bay Lake Tower at Disney's Contemporary Resort", "dinings"=>[], "permalink"=>"bay-lake-tower-at-disneys-contemporary-resort"}, 
{"name"=>"Disney's All-Star Movies Resort", "dinings"=>[{"name"=>"World Premiere Food Court", "permalink"=>"world-premier-food-court"}, 
{"name"=>"Silver Screen Spirits Bar", "permalink"=>"silver-screen-spirits-bar"}], "permalink"=>"disneys-all-star-movies-resort"}, 
{"name"=>"Disney's All-Star Music Resort", "dinings"=>[{"name"=>"Intermission Food Court", "permalink"=>"intermission-food-court"}, 
{"name"=>"Singing Spirits Bar", "permalink"=>"singing-spirits-pool-bar"}], "permalink"=>"disneys-all-star-music-resort"}, 
{"name"=>"Disney's All-Star Sports Resort", "dinings"=>[{"name"=>"End Zone Food Court", "permalink"=>"end-zone-food-court"}, 
{"name"=>"Team Spirits Bar", "permalink"=>"team-spirits-pool-bar"}], "permalink"=>"disneys-all-star-sports-resort"}, 
{"name"=>"Disney's Animal Kingdom Lodge", "dinings"=>[{"name"=>"Boma - Flavors of Africa", "permalink"=>"boma-flavors-of-africa"}, 
{"name"=>"Jiko - The Cooking Place", "permalink"=>"jiko-the-cooking-place"}, 
{"name"=>"Sanaa", "permalink"=>"sanaa"}, 
{"name"=>"The Mara", "permalink"=>"mara"}, 
{"name"=>"Victoria Falls Lounge", "permalink"=>"victoria-falls-lounge"}, 
{"name"=>"Maji Pool Bar", "permalink"=>"maji-pool-bar"}, 
{"name"=>"Uzima Springs Pool Bar", "permalink"=>"uzima-springs-pool-bar"}, 
{"name"=>"Kidani Village Private Dining", "permalink"=>"kidani-private-dining"}], "permalink"=>"disneys-animal-kingdom-lodge"}, 
{"name"=>"Disney's Animal Kingdom Villas", "dinings"=>[], "permalink"=>"disneys-animal-kingdom-villas"}, 
{"name"=>"Disney's Art of Animation Resort", "dinings"=>[{"name"=>"Landscape of Flavors", "permalink"=>"landscape-of-flavors"}, 
{"name"=>"The Drop Off Pool Bar", "permalink"=>"the-drop-off"}, 
{"name"=>"Pop Art Pizza Delivery", "permalink"=>"pop-art-pizza-delivery"}], "permalink"=>"disneys-art-of-animation-resort"}, 
{"name"=>"Disney's Beach Club Resort", "dinings"=>[{"name"=>"Beaches & Cream Soda Shop", "permalink"=>"beaches-cream-soda-shop"}, 
{"name"=>"Cape May Cafe", "permalink"=>"cape-may-cafe"}, 
{"name"=>"Yacht & Beach Club Private Dining", "permalink"=>"yacht-beach-club-private-dining"}, 
{"name"=>"Beach Club Marketplace", "permalink"=>"beach-club-marketplace"}, 
{"name"=>"Hurricane Hanna's Grill", "permalink"=>"hurricane-hannas-grill"}, 
{"name"=>"Martha's Vineyard Lounge", "permalink"=>"marthas-vineyard-lounge"}, 
{"name"=>"Beaches & Cream To Go", "permalink"=>"beaches-cream-to-go"}], "permalink"=>"disneys-beach-club-resort"}, 
{"name"=>"Disney's Beach Club Villas", "dinings"=>[], "permalink"=>"disneys-beach-club-villas"}, 
{"name"=>"Disney's BoardWalk Inn", "dinings"=>[{"name"=>"Big River Grille & Brewing Works", "permalink"=>"big-river-grille-brewing-works"}, 
{"name"=>"ESPN Club", "permalink"=>"espn-club"}, 
{"name"=>"Flying Fish Cafe", "permalink"=>"flying-fish-cafe"}, 
{"name"=>"Kouzzina by Cat Cora", "permalink"=>"kouzzina-by-cat-cora"}, 
{"name"=>"Belle Vue Lounge", "permalink"=>"belle-vue-lounge"}, 
{"name"=>"BoardWalk Bakery", "permalink"=>"boardwalk-bakery"}, 
{"name"=>"BoardWalk Pizza Window", "permalink"=>"boardwalk-pizza-window"}, 
{"name"=>"Seashore Sweets", "permalink"=>"seashore-sweets"}, 
{"name"=>"BoardWalk Joe's", "permalink"=>"boardwalk-joes"}, 
{"name"=>"BoardWalk To Go", "permalink"=>"boardwalk-to-go"}, 
{"name"=>"Leaping Horse Libations", "permalink"=>"leaping-horse-libations"}, 
{"name"=>"Funnel Cake Kiosk", "permalink"=>"funnel-cake-kiosk-boardwalk"}], "permalink"=>"disneys-boardwalk-inn"}, 
{"name"=>"Disney's BoardWalk Villas", "dinings"=>[], "permalink"=>"disneys-boardwalk-villas"}, 
{"name"=>"Disney's Caribbean Beach Resort", "dinings"=>[{"name"=>"Shutters at Old Port Royale", "permalink"=>"shutters-at-old-port-royale"}, 
{"name"=>"Old Port Royale Food Court", "permalink"=>"old-port-royale-food-court"}, 
{"name"=>"Banana Cabana", "permalink"=>"banana-cabana"}], "permalink"=>"disneys-caribbean-beach-resort"}, 
{"name"=>"Disney's Contemporary Resort", "dinings"=>[{"name"=>"California Grill", "permalink"=>"california-grill"}, 
{"name"=>"Chef Mickey's", "permalink"=>"chef-mickeys"}, 
{"name"=>"The Wave...of American Flavors", "permalink"=>"the-wave-restaurant"}, 
{"name"=>"Contempo Cafe", "permalink"=>"contempo-cafe"}, 
{"name"=>"Outer Rim Lounge", "permalink"=>"outer-rim-lounge"}, 
{"name"=>"Cove Bar", "permalink"=>"cove-bar"}, 
{"name"=>"The Sand Bar", "permalink"=>"sand-bar"}, 
{"name"=>"Top of the World Lounge", "permalink"=>"top-world-lounge"}, 
{"name"=>"Contemporary Grounds", "permalink"=>"contemporary-grounds"}], "permalink"=>"disneys-contemporary-resort"}, 
{"name"=>"Disney's Coronado Springs Resort", "dinings"=>[{"name"=>"Maya Grill", "permalink"=>"maya-grill"}, 
{"name"=>"Cafe Rix", "permalink"=>"cafe-rix"}, 
{"name"=>"Pepper Market", "permalink"=>"pepper-market"}, 
{"name"=>"Laguna Pool Bar", "permalink"=>"laguna-pool-bar"}, 
{"name"=>"Rix Lounge", "permalink"=>"rix-lounge"}, 
{"name"=>"Siestas Cantina", "permalink"=>"siestas-cantina"}], "permalink"=>"disneys-coronado-springs-resort"}, 
{"name"=>"Disney's Fort Wilderness Resort Cabins", "dinings"=>[{"name"=>"Hoop-Dee-Doo Musical Revue", "permalink"=>"hoop-dee-doo-revue"}, 
{"name"=>"Mickey's Backyard Barbeque Dinner Show", "permalink"=>"mickeys-backyard-bbq"}, 
{"name"=>"Trail's End Restaurant", "permalink"=>"trails-end-restaurant"}, 
{"name"=>"Meadow Snack Bar", "permalink"=>"meadow-snack-bar"}, 
{"name"=>"Trail's End Restaurant - To Go Counter", "permalink"=>"trails-end-restaurant-to-go-counter"}, 
{"name"=>"Crockett's Tavern", "permalink"=>"crocketts-tavern"}, 
{"name"=>"Chuck Wagon", "permalink"=>"chuck-wagon"}], "permalink"=>"fort-wilderness-resort-cabins"}, 
{"name"=>"Disney's Grand Floridian Resort", "dinings"=>[{"name"=>"1900 Park Fare", "permalink"=>"1900-park-fare"}, 
{"name"=>"Cítricos", "permalink"=>"citricos"}, 
{"name"=>"Grand Floridian Cafe", "permalink"=>"grand-floridian-cafe"}, 
{"name"=>"Narcoossee's", "permalink"=>"narcoossees"}, 
{"name"=>"Victoria & Albert's", "permalink"=>"victoria-alberts"}, 
{"name"=>"Grand Floridian Gingerbread House", "permalink"=>"Grand-FL-Gingerbread-House"}, 
{"name"=>"Gasparilla Island Grill", "permalink"=>"gasparilla-grill-games"}, 
{"name"=>"Garden View Tea Room", "permalink"=>"garden-view-tea-room"}, 
{"name"=>"Mizner's Lounge", "permalink"=>"mizners-lounge"}, 
{"name"=>"Beaches Pool Bar & Grill", "permalink"=>"beaches-pool-bar-grill"}, 
{"name"=>"Courtyard Pool Bar", "permalink"=>"courtyard-pool-bar"}], "permalink"=>"disneys-grand-floridian-resort"}, 
{"name"=>"Disney's Old Key West Resort", "dinings"=>[{"name"=>"Olivia's Cafe", "permalink"=>"olivias-cafe"}, 
{"name"=>"Good's Food to Go", "permalink"=>"goods-food-to-go"}, 
{"name"=>"Turtle Shack", "permalink"=>"turtle-shack"}], "permalink"=>"disneys-old-key-west-resort"}, 
{"name"=>"Disney's Polynesian Resort", "dinings"=>[{"name"=>"Kona Cafe", "permalink"=>"kona-cafe"}, 
{"name"=>"'Ohana", "permalink"=>"ohana"}, 
{"name"=>"Spirit of Aloha Dinner Show", "permalink"=>"spirit-of-aloha-dinner-show"}, 
{"name"=>"Capt. Cook's", "permalink"=>"captain-cooks"}, 
{"name"=>"Kona Island", "permalink"=>"kona-island"}, 
{"name"=>"Tambu Lounge", "permalink"=>"tambu-lounge"}, 
{"name"=>"Barefoot Pool Bar", "permalink"=>"barefoot-pool-bar"}], "permalink"=>"disneys-polynesian-resort"}, 
{"name"=>"Disney's Pop Century Resort", "dinings"=>[{"name"=>"Everything POP Shopping and Dining", "permalink"=>"everything-pop-food-court"}, 
{"name"=>"Petals Pool Bar", "permalink"=>"petals-pool-bar"}], "permalink"=>"disneys-pop-century-resort"}, 
{"name"=>"Disney's Port Orleans Resort - French Quarter", "dinings"=>[{"name"=>"Sassagoula Floatworks & Food Factory", "permalink"=>"sassagoula-floatworks-food-factory"}, 
{"name"=>"Scat Cat's Club", "permalink"=>"scat-cats-club"}, 
{"name"=>"Mardi Grogs", "permalink"=>"mardi-grogs"}], "permalink"=>"disneys-port-orleans-resort-french-quarter"}, 
{"name"=>"Disney's Port Orleans Resort - Riverside", "dinings"=>[{"name"=>"Boatwright's Dining Hall", "permalink"=>"boatwrights-dining-hall"}, 
{"name"=>"Riverside Mill Food Court", "permalink"=>"riverside-mill-food-court"}, 
{"name"=>"River Roost Lounge", "permalink"=>"river-roost-lounge"}], "permalink"=>"disneys-port-orleans-resort-riverside"}, 
{"name"=>"Disney's Saratoga Springs Resort & Spa", "dinings"=>[{"name"=>"The Turf Club Bar & Grill", "permalink"=>"turf-club-bar-grill"}, 
{"name"=>"The Artist's Palette", "permalink"=>"artists-palette"}, 
{"name"=>"The Paddock Grill", "permalink"=>"paddock-grill"}, 
{"name"=>"The Turf Club Lounge", "permalink"=>"turf-club-lounge"}, 
{"name"=>"Backstretch Pool Bar", "permalink"=>"backstretch-pool-bar"}, 
{"name"=>"On the Rocks", "permalink"=>"on-rocks"}], "permalink"=>"disneys-saratoga-springs-resort-spa"}, 
{"name"=>"Disney's Wilderness Lodge", "dinings"=>[{"name"=>"Artist Point", "permalink"=>"artist-point"}, 
{"name"=>"Whispering Canyon Cafe", "permalink"=>"whispering-canyon-cafe"}, 
{"name"=>"Roaring Fork", "permalink"=>"roaring-fork"}, 
{"name"=>"Territory Lounge", "permalink"=>"territory-lounge"}, 
{"name"=>"Miss Jenny's In-Room Dining", "permalink"=>"Miss-Jennys-In-Room-Dining"}], "permalink"=>"disneys-wilderness-lodge"}, 
{"name"=>"Disney's Wilderness Lodge Villas", "dinings"=>[], "permalink"=>"disneys-wilderness-lodge-villas"}, 
{"name"=>"Disney's Yacht Club Resort", "dinings"=>[{"name"=>"Captain's Grille", "permalink"=>"captains-grille"}, 
{"name"=>"Yachtsman Steakhouse", "permalink"=>"yachtsman-steakhouse"}, 
{"name"=>"Ale and Compass Lounge", "permalink"=>"ale-compass-lounge"}, 
{"name"=>"Crew's Cup Lounge", "permalink"=>"crews-cup-lounge"}], "permalink"=>"disneys-yacht-club-resort"}, 
{"name"=>"Dolphin at Walt Disney World", "dinings"=>[{"name"=>"Todd English's bluezoo", "permalink"=>"todd-english-bluezoo"}, 
{"name"=>"Fresh Mediterranean Market", "permalink"=>"fresh-mediterranean-market"}, 
{"name"=>"Shula's Steak House", "permalink"=>"shulas-steak-house"}, 
{"name"=>"The Fountain Eats and Sweets", "permalink"=>"fountain-eats-sweets"}, 
{"name"=>"Picabu", "permalink"=>"picabu"}, 
{"name"=>"Cabana Bar and Beach Club", "permalink"=>"cabana-bar-beach-club"}], "permalink"=>"dolphin-at-walt-disney-world"}, 
{"name"=>"Shades of Green at Walt Disney World", "dinings"=>[], "permalink"=>"shades-of-green-at-walt-disney-world"}, 
{"name"=>"Swan at Walt Disney World", "dinings"=>[{"name"=>"Garden Grove", "permalink"=>"garden-grove"}, 
{"name"=>"Il Mulino New York Trattoria", "permalink"=>"il-mulino-new-york-trattoria"}, 
{"name"=>"Kimonos", "permalink"=>"kimonos"}, 
{"name"=>"Java Bar", "permalink"=>"java-bar"}, 
{"name"=>"Splash Terrace", "permalink"=>"splash-terrace"}], "permalink"=>"swan-at-walt-disney-world"}, 
{"name"=>"The Villas at Disney's Grand Floridian Resort & Spa", "dinings"=>[], "permalink"=>"the-villas-at-disneys-grand-floridian-resort-and-spa"}, 
{"name"=>"Treehouse Villas at Disney's Saratoga Springs Resort", "dinings"=>[], "permalink"=>"treehouse-villas-at-disneys-saratoga-springs-resort"}]
    end
  end
  
  describe "find_resort_eateries_list_by_permalink" do

    let(:resort_permalink) {"disneys-all-star-movies-resort"}

    
    subject { WorldHarvester.find_resort_eateries_list_by_permalink(resort_permalink) }
    
    it "works" do
      subject.must_equal [{"name"=>"World Premiere Food Court", "permalink"=>"world-premier-food-court"}, {"name"=>"Silver Screen Spirits Bar", "permalink"=>"silver-screen-spirits-bar"}]
    end
  end
  
  describe "find_eatery_by_permalink" do
    let(:district_name) {"Animal Kingdom"}
    let(:eatery_permalink) {"pizzafari"}
    subject { WorldHarvester.find_eatery_by_permalink(district_name, eatery_permalink) }
    
    it "works" do
      subject.size.must_equal 45
      subject['permalink'].must_equal 'pizzafari'
      subject['name'].must_equal 'Pizzafari'
      subject['cuisine'].must_equal 'American'
    end
  end
  
  describe "find_menu_by_permalink" do
    
    # http://touringplans.com/magic-kingdom/dining/aloha-isle/menus/all-day-menu.json
    let(:district_name) {"Magic Kingdom"}
    let(:eatery_permalink) {"aloha-isle"}
    let(:menu_type_permalink) {"all-day-menu"}
    
    subject { WorldHarvester.find_menu_by_permalink(district_name, eatery_permalink, menu_type_permalink) }
    
    it "works" do
      subject.must_equal [{"menu"=>{"kids"=>false, "gratuity_included"=>false, "fixed_price_only"=>false, "adult_price"=>nil, "sales_tax_included"=>false, "description"=>"", "child_price"=>nil, "buffet"=>false, "name"=>"All Day Menu", "drinks"=>false, "verified_date"=>"May 21, 2014", "character_meal"=>false}}, {"dining"=>{"category_code"=>"counter_service", "short_name"=>"Aloha Isle"}}, {"menu_links"=>[{"links"=>[{"description"=>"", "price"=>"$3.29", "snack_credit"=>true, "name"=>"Fresh-cut Pineapple Spear", "market_price"=>false}, {"description"=>"", "price"=>"$2.99", "snack_credit"=>true, "name"=>"Assorted Chips", "market_price"=>false}, {"description"=>"", "price"=>"$3.29", "snack_credit"=>true, "name"=>"Fresh-cut Pineapple Spear", "market_price"=>false}], "group"=>"Snack"}, {"links"=>[{"description"=>"your choice of Pineapple, Vanilla, or Orange Dole Whip", "price"=>"$3.79", "snack_credit"=>true, "name"=>"Dole Whip Cup", "market_price"=>false}, {"description"=>"Your chioce of 2 flavors Pineapple, Vanilla, or Orange", "price"=>"$3.79", "snack_credit"=>true, "name"=>"Dole Whip Twist Cup", "market_price"=>false}, {"description"=>"Vanilla, Pineapple, or Orange Dole Whip with Pineapple Juice", "price"=>"$4.99", "snack_credit"=>true, "name"=>"Pineapple Float", "market_price"=>false}, {"description"=>"your chioce of Pineapple, Vanilla, or Orange Dole Whip", "price"=>"$4.49", "snack_credit"=>true, "name"=>"Fountain Beverage Float", "market_price"=>false}], "group"=>"Dessert"}, {"links"=>[{"description"=>nil, "price"=>"$4.00", "snack_credit"=>true, "name"=>"Smartwater", "market_price"=>false}, {"description"=>"", "price"=>"$2.50", "snack_credit"=>true, "name"=>"Dasani Bottled Water", "market_price"=>false}, {"description"=>"", "price"=>"$2.69", "snack_credit"=>true, "name"=>"Pineapple Juice", "market_price"=>false}, {"description"=>"", "price"=>"$3.79", "snack_credit"=>true, "name"=>"Simply Orange Orange Juice", "market_price"=>false}, {"description"=>"", "price"=>"$2.59", "snack_credit"=>true, "name"=>"Minute Maid Apple Juice", "market_price"=>false}, {"description"=>"", "price"=>"$2.29", "snack_credit"=>true, "name"=>"Hot Tea", "market_price"=>false}, {"description"=>"", "price"=>"$2.29", "snack_credit"=>true, "name"=>"Nestle Hot Cocoa", "market_price"=>false}, {"description"=>"regular or decaf", "price"=>"$2.29", "snack_credit"=>true, "name"=>"Coffee", "market_price"=>false}, {"description"=>"Coca-Cola, Diet Coke, Sprite, Minute Maid Light, Barq's Root Beer", "price"=>"$2.99", "snack_credit"=>true, "name"=>"Assorted Fountain Beverage - Regular", "market_price"=>false}, {"description"=>"Coca-Cola, Diet Coke, Sprite, Minute Maid Light, Barq's Root Beer", "price"=>"$3.19", "snack_credit"=>true, "name"=>"Assorted Fountain Beverage - Large", "market_price"=>false}], "group"=>"Beverage"}]}]
    end
  end
  
end