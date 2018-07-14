# frozen_string_literal: true

class HomeController < ApplicationController # :nodoc:

  before_action :authenticate_user!

  respond_to :html
  respond_to :js

  def index; end
end
