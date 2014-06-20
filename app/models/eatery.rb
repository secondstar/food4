require 'date'
require 'active_record'

class Eatery < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :district
  attr_accessor :notebook
  
  def self.most_recent
    all
  end
  
  def publish(clock=DateTime)
    return false unless valid?
    self.published_at = clock.now
    notebook.add_entry(self)
  end

  # def self.location_search(search)
  #
  #   if search
  #     search.gsub!(/[-\s]/, ' ')
  #     if search == 'resort dining'
  #       Client.where("orders_count = ? AND locked = ?", params[:orders], false)
  #       where('location NOT LIKE ? AND location NOT LIKE ?  AND location NOT LIKE ?', "%kingdom%", "%epcot%", "%hollywood%")
  #       find(:all, :conditions => ['location NOT LIKE ? AND location NOT LIKE ?  AND location NOT LIKE ?', "%kingdom%", "%epcot%", "%hollywood%"])
  #     else
  #       find(:all, :conditions => ['location LIKE ?', "%#{search}%"])
  #     end
  #   else
  #     find(:all)
  #   end
  # end

end