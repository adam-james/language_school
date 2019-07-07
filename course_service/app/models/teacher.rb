class Teacher < ApplicationRecord
  validates_presence_of :first_name, :last_name, :teachers_service_id
end
