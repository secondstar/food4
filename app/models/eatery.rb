require 'date'
require 'active_record'

class Eatery < ActiveRecord::Base
  include PgSearch
  ## scopes
  pg_search_scope :search_by_full_name, :against => [:name, :type_of_food]
  
  validates :name, :presence => true
  belongs_to :district
    
  has_many :photos, :as => :photogenic
  has_many :snapshots
  # has_many :reviews, :through => :snapshots  # this relationship should be more like in http://stackoverflow.com/questions/17541277/rails-has-many-through-aliasing-with-source-and-source-type-for-multiple-types and in evernote
  
  attr_accessor :notebook
  
  
  
  def self.most_recent
    all
  end
  
  def self.find_by_permalink_through_notebook
    @notebook = Notebook.new
  end

  def publish(clock=DateTime)
    return false unless valid?
    self.published_at = clock.now
    notebook.add_entry(self)
  end

  def self.update_with_review(permalink = "aloha-isle",
     review_type = "DisneyfoodblogComReview")
     puts "review_type is #{review_type} and permalink is #{permalink}"
    @notebook = Notebook.new
    eatery = @notebook.entries.where(permalink: permalink).first
    latest_snapshot = eatery.snapshots.where(review_type: review_type).order("updated_at DESC").first
    return if latest_snapshot.blank?
    latest_review = latest_snapshot.review
    if review_type == "DisneyfoodblogComReview"
      update_params = { id: eatery.id,
        service: latest_review.service,
        type_of_food: latest_review.type_of_food,
        location: latest_review.location,
        disney_dining_plan: latest_review.disney_dining_plan,
        tables_in_wonderland: latest_review.tables_in_wonderland,
        menu: latest_review.menu,
        important_info: latest_review.important_info,
        famous_dishes: latest_review.famous_dishes,
        # reviews: latest_review.reviews,
        you_might_also_like: latest_review.you_might_also_like}
      #   # breakfast_items: latest_review.breakfast_items,
      #   # drinks: latest_review.drinks,
      #   # special_treats: latest_review.special_treats}
      # # eatery.assign_attributes(update_params)      
    end
    if review_type == "TouringPlansComReview"
      puts "hi there #{permalink}"
      update_params = latest_review.attributes
      update_params.delete('archived_at')
      update_params.delete("id")
    end
    eatery.update(update_params)
    # return latest_review
  end
  
  def self.update_all_with_disneyfoodblog_com_reviews
    @notebook = Notebook.new
    eateries = @notebook.entries
    eateries.each do |eatery|
      self.update_with_review(permalink=eatery.permalink,
        review_type="DisneyfoodblogComReview")
    end
  end
  
  def self.update_all_with_touring_plans_com_reviews
    @notebook = Notebook.new
    eateries = @notebook.entries
    eateries.each do |eatery|
      self.update_with_review(permalink= eatery.permalink,
        review_type="TouringPlansComReview")
    end
  end
  
  def self.all_at_resorts
    @eateries   = Array.new
    @resorts    = District.resorts
    @resorts.each do |resort|
      resort.eateries.each do |eatery|
        @eateries <<  eatery
      end
    end
    @eateries
  end
  
  def self.all_at_disney_springs
    @eateries   = Array.new
    @disney_springs_districts = District.disney_springs
    @disney_springs_districts.each do |dsdd|
      dsdd.eateries.each do |eatery|
        @eateries <<  eatery
      end
    end
    @eateries
  end
  
end