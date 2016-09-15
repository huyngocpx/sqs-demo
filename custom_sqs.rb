class CustomSQS
  class << self

    def create_queue(sqs_client, queue_name)
      begin
        sqs_client.get_queue_url(queue_name: queue_name)
        p "Queue named '#{queue_name}' already existed"
      rescue Aws::SQS::Errors::NonExistentQueue
        sqs_client.create_queue({ queue_name: queue_name})
        p "Create queue '#{queue_name}' successfully!"
      end
    end

    def list_all_queues(sqs_client)
      puts "\nList all queues:"
      sqs_client.list_queues.each do |queue|
        puts "\t#{queue.queue_urls}"
      end
    end

    def send_random_message(sqs_client, queue_name)
      begin
        queue_url = sqs_client.get_queue_url(queue_name: queue_name).queue_url
        sqs_client.send_message({
          queue_url: queue_url,
          message_body: {
            name: "p#{Random.new.rand(100000)}",
            age: Random.new.rand(20..80)
          }.to_json
        })
      rescue Aws::SQS::Errors::NonExistentQueue
        p "Queue named '#{queue_name}' didn't exist."
      end
    end

    def delete_queue(sqs_client, queue_name)
      begin
        queue_url = sqs_client.get_queue_url(queue_name: queue_name).queue_url
        sqs_client.delete_queue({ queue_url: queue_url })
        p "Delete queue '#{queue_name}' successfully!"
      rescue Aws::SQS::Errors::NonExistentQueue
        p "Queue named '#{queue_name}' didn't exist."
      end
    end
  end
end
