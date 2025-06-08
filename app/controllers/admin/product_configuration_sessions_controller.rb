module Admin
  class ProductConfigurationSessionsController < Admin::ApplicationController
    def scoped_resource
      resource_class.order(created_at: :desc)
    end
  end
end
