class District < ActiveRecord::Base
  validates :name, :presence => true
  
  attr_accessor :notebook
  
  def publish(clock=DateTime)
    return false unless valid?
    self.published_at = clock.now
    save!
  end
  
  # Touringplans.com does not have a list of parks, so we generate and store one in districts
  def self.update_each
    @districts  = [{name: "Magic Kingdom", permalink:   "magic-kingdom", is_park:  true},
       {name: "Animal Kingdom", permalink:   "animal-kingdom", is_park:  true},
       {name: "Epcot", permalink:   "epcot", is_park:  true},
       {name: "Disney's Hollywood Studios", permalink:   "hollywood-studios", is_park:  true},
       {name: "Blizzard Beach", permalink:   "blizzard-beach", is_park:  true},
       {name: "Typhoon Lagoon", permalink:   "typhoon-lagoon", is_park:  true},
       {name: "Resorts", permalink:   "resorts", is_park:  false},
       {name: "Downtown Disney", permalink:  "downtown-disney", is_park:  false},
      ]
    
    @districts.each do |district|
      params = {credit:  'touring_plans.com'}
      params = params.merge(district)
      puts params['permalink']
      District.find_or_initialize_by(permalink: params[:permalink]) do |district| # test if resort district already exists
        district.name = params[:name]
        district.is_park = params[:is_park]
        district.credit = params[:credit]       
        if district.publish
          puts "Saved #{district.name}"
        end
      end
      
    end
    
  end
  
end
