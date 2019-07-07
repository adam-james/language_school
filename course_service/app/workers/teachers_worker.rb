class TeachersWorker
  include Sneakers::Worker
  from_queue 'teachers.created', env: nil

  def work(teacher_json)
    attrs = deserialize(teacher_json)
    Teacher.create!(attrs)
    ack!
  end

  private

  def deserialize(teacher_json)
    parsed = JSON.parse(teacher_json)
    attrs = {
      first_name: parsed['first_name'],
      last_name: parsed['last_name'],
      teachers_service_id: parsed['id']
    }
    attrs
  end
end
