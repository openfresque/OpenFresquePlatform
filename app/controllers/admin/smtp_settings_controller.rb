module Admin
  class SmtpSettingsController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes(action_name)).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-demo.herokuapp.com/customizing_controller_actions
    # for more information

    # Prevent creation of new SmtpSetting if one already exists
    def authorized_action?(_resource, _action_name)
      if _action_name.to_sym == :new
        return false if SmtpSetting.exists?
      end
      super
    end

    def new
      if SmtpSetting.exists?
        redirect_to_existing_or_show_error
      else
        super
      end
    end

    def create
      if SmtpSetting.exists?
        redirect_to_existing_or_show_error
      else
        super
      end
    end

    private

    def redirect_to_existing_or_show_error
      existing_setting = SmtpSetting.first
      flash[:alert] = "An SMTP setting already exists. You can edit it instead."
      redirect_to [:admin, existing_setting] # Redirect to the show page of the existing record
    end
  end
end
