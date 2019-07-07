module PubSub
  class TeachersPublisher < Publisher
    def self.publish_created(teacher)
      self.publish(teacher.to_json, 'teachers.created')
    end

    def self.publish_updated(teacher)
      self.publish(teacher.to_json, 'teachers.updated')
    end
  end
end
