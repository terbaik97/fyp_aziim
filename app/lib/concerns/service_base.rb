# typed: false

# Usage (will remove and mention it as documentation later):
#
# class XService
#   include Airhost::ServiceModule
#
#   validates :attr, presence: true
#
#   def initialize(attr)
#     @attr = attr
#   end
#
#   def process
#     y_result = YService.call(attr) # assume there is a YService
#
#     return y_result if y_result.failure?
#
#     raise TheError, "some error" if something_went_wrong
#
#     { some_attr: "very useful" }
#   end
#
#   private
#
#   attr_reader :attr
# end
#
# result = XService.call(attr)
#
# if result.success?
#   puts "What is some attr?"
#   puts result.data[:some_attr]
# else
#   puts "why is there an error?"
#   puts result.error
#   pp result.error.backtrace
# end

module ServiceBase
    extend ActiveSupport::Concern
    include ActiveModel::Validations
  
    class FailedValidationError < StandardError
      attr_accessor :data
  
      def initialize(message, data = nil)
        super(message)
  
        @data = data || message
      end
    end
  
    Result = Struct.new(:error, :data) do
      def success?
        !error.present?
      end
  
      def failure?
        !success?
      end
    end
  
    module ClassMethods
      def call!(*args)
        service_obj = self.new(*args)
  
        unless service_obj.valid?
          error_data = service_obj.handle_validation_errors
          return error_data if error_data.is_a?(Result)
          error = FailedValidationError.new("Failed to validate for #{self}")
          error.data = service_obj.errors
          raise error
        end
  
        begin
          data = service_obj.process
          data.is_a?(Result) ? data : Result.new(nil, data)
        rescue => ex
          error_data = service_obj.on_error(ex)
          return error_data if error_data.is_a?(Result)
          raise
        end
      end
  
      def call(*args)
        call!(*args)
      rescue FailedValidationError => e
        Result.new(e, e.data)
      rescue => e
        Result.new(e)
      end
    end
  
    def process
      raise NotImplementedError
    end
  
    # suppress errors by default
    def handle_validation_errors; end
    def on_error(ex); end
  
    private
  
    def logger
      @logger ||= Rails.logger
    end
  
    def error_result(ex, data = nil)
      Result.new(ex, data)
    end
  end
  