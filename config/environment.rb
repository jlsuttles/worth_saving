# Load the rails application
require File.expand_path('../application', __FILE__)

# Must be done after loading the application and before running initialize.  Otherwise test suite fails.
require 'worth_saving'

# Initialize the rails application
WorthSaving::Application.initialize!
