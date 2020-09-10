class Appointment < ApplicationRecord
   belongs_to :doctor, :class_name => 'User',foreign_key: :doctor_id 
   belongs_to :patient, :class_name => 'User',foreign_key: :patient_id 
   validate :datetime_is_valid

   # appointment datetime slot
   def datetime_is_valid
   	self.doctor.appointments.each do |appointment|
   		
   		if((appointment.start_date_time...appointment.end_date_time).include?(self.start_date_time) || (appointment.start_date_time...appointment.end_date_time).include?(self.end_date_time))
   			 errors.add(:error, "date and time is not valid ") 
   		end	
   	end
	end
end
