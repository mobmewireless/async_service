
## Description

AsyncService provides an abstraction for workers/daemons that processes work from a queue. Often an AsyncService::Worker will get work from a queue, process it and push the result back into another queue.

You can also take a look at [SyncService](https://github.com/mobmewireless/sync_service) which provides abstractions for synchronous SOA.

## Install

    $ gem install async_service

## Creating a Worker

    class CalculatorMachine < AsyncService::Worker
      # You need to set a service name
      @service_name = 'in.mobme.calculator_machine'

      # This function is called on run
      def work
        loop do
          queue.remove("work_queue") do |item|
            result = item[:a] + item[:b]

            queue.add("result_queue", result)
          end
          sleep 5
        end
      end
    end

    calculator = CalculatorMachine.new
    calculator.run

