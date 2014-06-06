class NotebookController < ApplicationController
  def index
    @notebook = Notebook.new
    # eatery1 = @notebook.new_eatery
    # eatery1.title = "Pizzafari"
    # eatery1.body = "Let's eat pizza!"
    # eatery1.publish
    # eatery2 = @notebook.new_eatery(title: "Beast's Castle")
    # eatery2.body = "Everyone comes here."
    # eatery2.publish
  end
end
