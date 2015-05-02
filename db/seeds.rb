# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
District.delete_all

districts = District.create([{name: "Magic Kingdom", permalink: "magic-kingdom", is_park: true, credit: "touring_plans.com }, { name: "Animal Kingdom", permalink: "animal-kingdom", is_park: true, credit: "touring_plans.com" }, {  
name: "Epcot", permalink: "epcot", is_park: true, credit: "touring_plans.com" }, {  
name: "Disney's Hollywood Studios", permalink: "hollywood-studios", is_park: true, credit: "touring_plans.com" }, {  
name: "Blizzard Beach", permalink: "blizzard-beach", is_park: true, credit: "touring_plans.com" }, {  
name: "Typhoon Lagoon", permalink: "typhoon-lagoon", is_park: true, credit: "touring_plans.com" }, {  
name: "Resorts", permalink: "resorts", is_park: false, credit: "touring_plans.com" }, {  
name: "Downtown Disney", permalink: "downtown-disney", is_park: false, credit: "touring_plans.com" }, {  
name: "Bay Lake Tower at Disney's Contemporary Resort", permalink: "bay-lake-tower-at-disneys-contemporary-resort", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's All-Star Movies Resort", permalink: "disneys-all-star-movies-resort", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's All-Star Music Resort", permalink: "disneys-all-star-music-resort", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's All-Star Sports Resort", permalink: "disneys-all-star-sports-resort", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Animal Kingdom Lodge", permalink: "disneys-animal-kingdom-lodge", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Animal Kingdom Villas", permalink: "disneys-animal-kingdom-villas", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Art of Animation Resort", permalink: "disneys-art-of-animation-resort", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Beach Club Resort", permalink: "disneys-beach-club-resort", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Beach Club Villas", permalink: "disneys-beach-club-villas", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's BoardWalk Inn", permalink: "disneys-boardwalk-inn", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's BoardWalk Villas", permalink: "disneys-boardwalk-villas", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Caribbean Beach Resort", permalink: "disneys-caribbean-beach-resort", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Contemporary Resort", permalink: "disneys-contemporary-resort", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Coronado Springs Resort", permalink: "disneys-coronado-springs-resort", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Fort Wilderness Resort Cabins", permalink: "fort-wilderness-resort-cabins", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Grand Floridian Resort", permalink: "disneys-grand-floridian-resort", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Old Key West Resort", permalink: "disneys-old-key-west-resort", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Polynesian Resort", permalink: "disneys-polynesian-resort", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Pop Century Resort", permalink: "disneys-pop-century-resort", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Port Orleans Resort - French Quarter", permalink: "disneys-port-orleans-resort-french-quarter", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Port Orleans Resort - Riverside", permalink: "disneys-port-orleans-resort-riverside", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Saratoga Springs Resort & Spa", permalink: "disneys-saratoga-springs-resort-spa", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Wilderness Lodge", permalink: "disneys-wilderness-lodge", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Wilderness Lodge Villas", permalink: "disneys-wilderness-lodge-villas", is_park: false, credit: "touringplans.com" }, {  
name: "Disney's Yacht Club Resort", permalink: "disneys-yacht-club-resort", is_park: false, credit: "touringplans.com" }, {  
name: "Dolphin at Walt Disney World", permalink: "dolphin-at-walt-disney-world", is_park: false, credit: "touringplans.com" }, {  
name: "Shades of Green at Walt Disney World", permalink: "shades-of-green-at-walt-disney-world", is_park: false, credit: "touringplans.com" }, {  
name: "Swan at Walt Disney World", permalink: "swan-at-walt-disney-world", is_park: false, credit: "touringplans.com" }, {  
name: "The Villas at Disney's Grand Floridian Resort & Sp...", permalink: "the-villas-at-disneys-grand-floridian-resort-and-s...", is_park: false, credit: "touringplans.com" }, {  
name: "Treehouse Villas at Disney's Saratoga Springs Reso...", permalink: "treehouse-villas-at-disneys-saratoga-springs-resor...", is_park: false, credit: "touringplans.com"}])