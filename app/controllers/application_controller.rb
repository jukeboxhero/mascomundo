class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :fetch_categories
  before_action :set_default_layout_variables

  def set_default_layout_variables
    @navbar = true
    @breadcrumbs = true
  end

  def fetch_categories
    taxon = Spree::Taxon.where(parent_id: nil, permalink: "categories").first
    @categories = taxon.try(:children) || []
  end
end
