# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# Note: If a preference is set here it will be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will not make the preference value go away.
#       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
  Spree::Image.attachment_definitions[:attachment][:styles] = {
    :mini => '48x48>',
    :small => '100x100>',
    :product => '260x300#',
    :large => '900x1038#'
  }
end

Spree.user_class = "Spree::LegacyUser"

# use custom search class
require "#{Rails.root}/lib/spree/custom_search"
Spree::Config.searcher_class = Spree::CustomSearch
