class CreateParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :participations do |t|
      t.references :user, null: false
      t.references :training_session, null: false
      t.string :status, null: false, default: "PENDING"
      t.datetime :presence_recorded_at, null: true
      t.references :animator, null: false, foreign_key: {to_table: :users}
      
      t.timestamps
    end
  end
end
