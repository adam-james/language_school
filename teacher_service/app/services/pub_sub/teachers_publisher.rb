module PubSub
  class TeachersPublisher < Publisher
    def self.publish_created(teacher)
      self.publish(teacher.to_json, 'teachers.created')
    end
  end
end
