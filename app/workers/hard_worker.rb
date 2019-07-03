class HardWorker
  include Sidekiq::Worker

  def perform(args)
    logger.info args.inspect
    reading = Reading.create(args)
    binding.pry
    unless reading.blank?
      return {tracking_number: reading.tracking_number}
    else
      return {tracking_number: reading.tracking_number}
    end
  end
end
