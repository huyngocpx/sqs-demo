require 'aws-sdk'
require './custom_sqs'

# configure AWS SQS
Aws.config.update(
  access_key_id: 'x',
  secret_access_key: 'y',
  region: 'localhost',
  sqs: {
    endpoint: "http://localhost:9324"
  }
)
queue_name = 'pixtavietnam-local'
sqs_client = Aws::SQS::Client.new

begin

  puts "Select your choice:"
  puts "\t1. Create queue"
  puts "\t2. List all queue"
  puts "\t3. Send random message"
  puts "\t4. Delete queue"
  print "\nEnter your selection:\t"

  case gets.chomp
  when '1'
    # create queue
    CustomSQS.create_queue(sqs_client, queue_name)
  when '2'
    # list all queues
    CustomSQS.list_all_queues(sqs_client)
  when '3'
    # send message to pixtavietnam-local, particular example for a json message
    CustomSQS.send_random_message(sqs_client, queue_name)
  when '4'
    # delete queue
    CustomSQS.delete_queue(sqs_client, queue_name)
  else
    puts "Not valid option"
  end

  print "Do you want to continue? (y/n)\t"
end while gets.chomp == 'y'
