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

# get queue url
queue_name = 'pixtavietnam-local'
sqs_client = Aws::SQS::Client.new

begin
  queue_url = sqs_client.get_queue_url(queue_name: queue_name).queue_url
  # get message
  poller = Aws::SQS::QueuePoller.new(queue_url)
  poller.poll do |msg|
    result_json = JSON.parse(msg.body)
    p "Person(name: #{result_json["name"]}, age: #{result_json["age"]})"
  end
rescue Aws::SQS::Errors::NonExistentQueue
  p "Queue named '#{queue_name}' didn't exist. Please create before running this file!"
end
