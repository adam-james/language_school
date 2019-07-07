module Teachers
  class UpdatedWorker < Worker
    include Sneakers::Worker
    from_queue 'teachers.updated', env: nil

    def work(teacher_json)
      attrs = deserialize(teacher_json)
      teacher = find_teacher!(attrs)
      teacher.update!(attrs)
      ack!
    end

    private

    def find_teacher!(attrs)
      teachers_service_id = attrs[:teachers_service_id]
      Teacher.find_by!(teachers_service_id: teachers_service_id)
    end
  end
end
