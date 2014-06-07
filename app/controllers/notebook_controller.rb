class NotebookController < ApplicationController
  def index
    @notebook = Notebook.new
    eatery1 = @notebook.new_eatery
    eatery1.name = "Pizzafari"
    eatery1.permalink = "/columbia-harbour-house"
    eatery1.publish
    eatery2 = @notebook.new_eatery(name: "Beast's Castle")
    eatery2.permalink = "/columbia-harbour-house2"
    eatery2.publish
  end
end
