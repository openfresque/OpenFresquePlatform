class TrainingSessionsController < ::OpenFresk::TrainingSessionsController

  before_action :set_training_session,
                  only: %i[edit update destroy product_configurations set_product_configurations show_public]
  
  def create
    command = ::TrainingSessions::CreateTrainingSession.new(
      training_session_params: training_session_params,
      current_user: current_user,
      contact: params.dig(:contact),
      past: params.dig(:past),
      context: params.dig(:context)
    )
    @training_session = command.call

    if @training_session.errors.blank?
        redirect_to product_configurations_training_session_path(@training_session),
        notice: t("training_sessions.created")
    else
      render :new
    end
  end

  def product_configurations
    @product_configurations = @training_session
                              .country
                              .product_configurations
                              .joins(:product)
                              .where(product: {category: @training_session.category})
                              .where.not(product: {identifier: "COUPON"})
                              .order(:before_tax_price_cents)
                              .includes([:product])

    return unless @product_configurations.size <= 1
  end
    
  def set_product_configurations
    product_configurations = ProductConfiguration.where(id: params[:product_configurations])

    if product_configurations.blank?
      redirect_to product_configurations_training_session_path(@training_session),
                  notice: "training_sessions.no_product_selected"
      return
    end

    @training_session.product_configuration_sessions.destroy_all

    product_configurations.each do |product_configuration|
      ProductConfigurationSession.create(
        training_session: @training_session,
        product_configuration:
      )
    end
    redirect_to edit_training_session_path(@training_session),
                notice: t("training_sessions.updated")
  end

  def show_public
    @participation = Participation.new(training_session: @training_session)
    training_session_products
  end

  private

  def training_session_products
    @products = @training_session
                .product_configuration_sessions
                .includes(:product_configuration)
                .order("product_configurations.before_tax_price_cents")
  end
end
