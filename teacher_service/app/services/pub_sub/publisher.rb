module PubSub
  class Publisher
    def self.publish(message, routing_key)
      new(message, routing_key).publish
    end

    def initialize(message, routing_key)
      @message = message
      @routing_key = routing_key
    end

    def publish
      exchange.publish(message, routing_key: routing_key)
    end

    private

    attr_reader :message, :routing_key

    CONFIG = {
      host: ENV['AMQP_HOST']
    }

    def connection
      @connection ||= Bunny.new(CONFIG).tap do |conn|
        conn.start
      end
    end

    def channel
      @channel ||= connection.create_channel
    end

    def exchange
      @exchange ||= channel.direct('sneakers', durable: true)
    end
  end
end
