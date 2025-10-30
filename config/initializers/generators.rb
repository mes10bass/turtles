# frozen_string_literal: true

Rails.application.configure do
  config.generators do |g|
    g.stylesheets false
    g.helper false
    g.test_framework :rspec, view_specs: false, helper_specs: false
  end
end
