require 'sneakers'

Sneakers.configure :amqp => ENV.fetch('AMQP_URL', 'amqp://rabbitmq')
