class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.integer :doctor_id
      t.integer :patient_id
      t.datetime :start_date_time
      t.datetime :end_date_time

      t.timestamps
    end
  end
end
