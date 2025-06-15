module Admin
  class ProductConfigurationsController < Admin::ApplicationController
    def index
      authorize_resource(resource_class)
      search_term = params[:search].to_s.strip
      resources = ProductConfiguration
                  .joins(:country)
                  .where("countries.code ILIKE ?", "%#{search_term}%")
      resources = apply_collection_includes(resources)
      resources = order.apply(resources)
      resources = resources.page(params[:_page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order:)

      render locals: {
        resources:,
        search_term:,
        page:,
        show_search_bar: show_search_bar?
      }
    end

    def search
      authorize_resource(resource_class)
      resources = ProductConfiguration
                  .joins(:country)
                  .where("countries.id = ?", params[:country_filtering])
      resources = apply_collection_includes(resources)
      resources = order.apply(resources)
      resources = resources.page(params[:_page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order:)

      render locals: {
        resources:,
        page:,
        show_search_bar: show_search_bar?
      }
    end

    def upload
      ProductConfigurations::ImportProductConfigurationsCsv.call(params[:csv])
      redirect_to admin_product_configurations_path, notice: "Votre import est réussie"
    end

    def download_csv_template
      send_file "resources/template_product_configurations.csv", type: "text/csv", disposition: "attachment"
    end
  end
end
