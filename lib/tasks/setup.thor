class Setup < Thor
  
  desc "config [NAME]", "copy configuration files"
  method_options :force => :boolean
  def config(name = "*")
        # Config method body omitted.
  end
  
  desc "populate", "generate records"
  def populate
    require "./config/environment"
    10.times do |num|
      puts "Generating Eatery #{num}"
      Eatery.create!(:name => "Article #{num}")
    end
  end

  desc "initialize_district_values", "generate initial district values"
  def seed_districts
    
  end
end