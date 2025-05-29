module Admin
  class OpenFreskSettingsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions.
    # Actions Nnew and Create are redefined to ensure only one record can be created

    # Prevent creation of new OpenFreskSetting if one already exists
    def authorized_action?(_resource, _action_name)
      if _action_name.to_sym == :new
        return false if OpenFreskSetting.exists?
      end
      super
    end

    # GET /admin/open_fresk_settings/new
    def new
      if OpenFreskSetting.exists?
        redirect_to_existing_or_show_error
      else
        super
      end
    end

    # POST /admin/open_fresk_settings
    def create
      if OpenFreskSetting.exists?
        redirect_to_existing_or_show_error
      else
        super
      end
    end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   OpenFreskSetting.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #  # Or some other custom scoping query such as:
    #  # OpenFreskSetting.order(created_at: :desc)
    #   super
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes(action_name)).
    #     transform_values { |value| value == \"\" ? nil : value }
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information

    private

    def redirect_to_existing_or_show_error
      existing_setting = OpenFreskSetting.first
      flash[:alert] = "An OpenFreskSettings record already exists. You can edit it instead."
      # Redirect to the edit page of the existing record, as there's usually no show page for singletons
      redirect_to [:edit, :admin, existing_setting]
    end
  end
end 