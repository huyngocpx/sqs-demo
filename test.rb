require 'aws-sdk'

# configure AWS SQS
Aws.config.update(
  access_key_id: 'x',
  secret_access_key: 'y',
  region: 'localhost',
  sqs: {
    endpoint: "http://localhost:9324"
  }
)

# create queue
queue_name = 'pixtavietnam-local'
sqs_client = Aws::SQS::Client.new
queue = sqs_client.create_queue({ queue_name: queue_name})
puts "Create queue '#{queue_name}' successfully!"

# list all queues
puts "\nList all queues:"
sqs_client.list_queues.each do |queue|
  puts "\t#{queue.queue_urls}"
end

# send message to pixtavietnam-local, particular example for a json message
sqs_client.send_message({
  queue_url: queue.queue_url,
  message_body: {
    name: "p#{Random.new.rand(100000)}",
    age: Random.new.rand(20..80)
  }.to_json
})

# delete queue
sqs_client.delete_queue({
  queue_url: queue.queue_url
})
