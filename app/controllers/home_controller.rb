class HomeController < ApplicationController
  require File.join(Rails.root, 'lib', 'authenticated_system.rb')
  include AuthenticatedSystem

  def index
  end

end
