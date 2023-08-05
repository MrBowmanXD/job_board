class PagesController < ApplicationController
  def home
    @jobs = Job.limit(4)
  end

  def about
  end

  def contact
  end
end
