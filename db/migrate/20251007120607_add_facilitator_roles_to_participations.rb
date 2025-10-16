class AddFacilitatorRolesToParticipations < ActiveRecord::Migration[7.0]
  def change
    add_column :participations, :facilitator_role, :string, null: true
  end
end
