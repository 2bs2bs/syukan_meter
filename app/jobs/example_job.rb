class ExampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Hello from sidekiq"
  end
end
