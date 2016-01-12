class Developers::SpecialtyController < ApplicationController

  def database
    @developers = Developer.where(specialty: "database")
  end

  def front_end
    @developers = Developer.where(specialty: "front_end")
  end

  def back_end
    @developers = Developer.where(specialty: "back_end")
  end

end