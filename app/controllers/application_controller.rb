class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter do
    instance_variables.each do |i|
      logger.info "#{i}"
    end
  end
end
