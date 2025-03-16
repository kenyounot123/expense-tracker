class LandingsController < ApplicationController
  allow_unauthenticated_access
  layout "landing"
  def index
  end

  def privacy
  end

  def terms
  end
end
