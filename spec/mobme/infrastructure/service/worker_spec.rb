require 'spec_helper'

require 'async_service'

class DummyWorker < AsyncService::Worker
  @service_name = 'infrastructure-service-worker-dummy'
end

describe DummyWorker do
  describe "class" do
    it "should define a service name" do
      DummyWorker.service_name.should_not be_nil
    end
  end

  it { should respond_to(:queue) }
  it { should respond_to(:queue).with(1).argument }

  before(:each) do
    @dummy_worker = DummyWorker.new
  end

  it "should log and re-raise any uncaught errors while running" do
    dummy_worker = DummyWorker.new
    dummy_worker.logger.should_receive(:error)
    lambda { dummy_worker.run }.should raise_error
  end

  describe "#logger" do
    let(:dummy_logger) { double Logger }

    it "returns a logger instance" do
      Logger.should_receive(:new).with(STDOUT).and_return(dummy_logger)
      subject.logger
    end

    context "when called more than once" do
      it "returns the same logger instance" do
        Logger.stub(:new).and_return(dummy_logger)
        subject.logger.should be dummy_logger
        subject.logger.should be dummy_logger
      end
    end
  end

  describe "queue" do
    let(:dummy_work_queue) { double('Queue').as_null_object }

    before :each do
      TrueQueue.stub!(:queue).and_return(dummy_work_queue)
    end

    it "should return a connected queue with a same name as the service_name" do
      TrueQueue.should_receive(:queue).with(:redis, {}).and_return(dummy_work_queue)
      @dummy_worker.queue
    end

    context "when options are passed" do
      it "passes on the options to Queue.queue" do
        options = double("Options", :empty? => false)
        TrueQueue.should_receive(:queue).with(:redis, options)
        @dummy_worker.queue(:redis, options)
      end
      
      it "passes on the type to Queue.queue" do
        TrueQueue.should_receive(:queue).with(:memory, {})
        @dummy_worker.queue(:memory)
      end
    end
  end
end



