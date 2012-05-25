
module MobME::Infrastructure::Service
  class Worker
    def self.service_name
      @service_name
    end
    
    def logger
      @logger ||= Logger.new(STDOUT)
    end
    
    def queue(type = :redis, options = {})      
      TrueQueue.queue(type, options)
    end

    def run
      begin
        logger.info "Starting #{self.class}.."
        work
      rescue StandardError => e
        logger.error(e.backtrace.unshift(e.inspect).join("\n"))
        raise
      end
    end
  end
end
