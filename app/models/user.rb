class User < OpenFresk::User
  def can?(action_name)
    rule = Rule.joins(:permission_action).find_by(permission_actions: { name: action_name })
    rule&.user_roles&.map(&:name)&.include?(user_role)
  end
end