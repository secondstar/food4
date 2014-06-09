class District < ActiveRecord::Base
  
  attr_accessor :notebook
  
  def publish(clock=DateTime)
    return false unless valid?
    self.published_at = clock.now
    notebook.add_entry(self)
  end
  
  # Touringplans.com does not have a list of parks, so we generate and store one in districts
  def find_park_districts_and_update(info_credit) 
    @districts  = [{"name" => "Magic Kingdom", "permalink" =>  "magic-kingdom"},
       {"name" => "Animal Kingdom", "permalink" =>  "animal-kingdom"},
       {"name" => "Epcot", "permalink" =>  "epcot"},
       {"name" => "Disney's Hollywood Studios", "permalink" =>  "hollywood-studios"},
       {"name" => "Blizzard Beach", "permalink" =>  "blizzard-beach"},
       {"name" => "Typhoon Lagoon", "permalink" =>  "typhoon-lagoon"} ]
    
    @districts.each do |district|
      @district = District.find_or_initialize_by_permalink(district['permalink']) # test if resort district already exists
      @district.permalink = district['permalink']
      @district.name = district['name']
      @district.credit = info_credit
      @district.is_park = true
      if @district.save! 
        puts "Saved " + @district.name
      end
    end
    
  end
  
end
