module Users
  class CreateUser
    include SimpleCommand

    def initialize(user_params:, country_params:, current_user:, user_tenant_role:, language: nil)
      @user_params = user_params
      @country_params = country_params
      @current_user = current_user
      @user_tenant_role = user_tenant_role
      @language = language
    end

    def call
      ActiveRecord::Base.transaction do
        @user_uuid = UserUuid.create!(uuid: SecureRandom.uuid)
        AnimatorInfo.create!(user_uuid: @user_uuid.uuid)
      end

      @user = User.new(user_params)
      @user.uuid = @user_uuid.uuid
      @user.token = SecureRandom.uuid
      @user.refresh_token = SecureRandom.uuid
      @user.country_id = country_params[:country_id].to_i
      set_language
      @user.cgu = Time.current if user_params[:cgu] == "1"
      @user.save

      return @user if @user.errors.present?

      UserTenant.create!(
        user_uuid: @user_uuid.uuid,
        role: user_tenant_role,
        tenant: Tenant.current,
        created_by_user_uuid: current_user&.uuid,
        created_by_tenant_id: Tenant.current.id,
        main: true
      )

      @user
    end

    private

    attr_reader :user_params, :country_params, :current_user, :user_tenant_role, :language

    def set_language
      @user.native_language = if @language.present?
                                Constants::Locales::LIST.include?(@language) ? @language : "en"
                              else
                                Constants::Locales::LIST.include?(@user.country&.code&.downcase) ? @user.country&.code&.downcase : "en"
                              end
    end
  end
end
