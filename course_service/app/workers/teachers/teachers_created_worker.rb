module Teachers
  class CreatedWorker < Worker
    include Sneakers::Worker
    from_queue 'teachers.created', env: nil
  
    def work(teacher_json)
      attrs = deserialize(teacher_json)
      Teacher.create!(attrs)
      ack!
    end
  end
end
