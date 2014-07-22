# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
every :tuesday, :at => '1:30 am' do # Use any day of the week or :weekend, :weekday
  # update all the Disney Food Blog reviews at WDW
  command "thor update_from_disney_food_blog:all_reviews;thor update_from_disney_food_blog:update_all_eateries_with_disneyfoodblog_com_reviews"
end

every :wednesday, :at => '1:30 am' do # Use any day of the week or :weekend, :weekday
  #update eateries with the Disney Food Blog reviews downloaded the night before
  # update the eateries and Touring Plans reviews of all of WDW
  command "thor update_from_touring_plans:downtown_disney;thor update_from_touring_plans:lodgings;thor update_from_touring_plans:parks;thor update_from_touring_plans:update_all_eateries_with_touringplans_com_reviews"
end

every :thursday, :at => '1:30 am' do # Use any day of the week or :weekend, :weekday
  # update the links to flickr photos.
  command "thor update_from_flickr:eatery_photos;thor update_from_flickr:park_photos;thor update_from_flickr:resort_photos"
end

# Learn more: http://github.com/javan/whenever
