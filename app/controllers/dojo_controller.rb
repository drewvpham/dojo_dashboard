class DojoController < ApplicationController
  def index
    @dojos=Dojo.all
  end
end
