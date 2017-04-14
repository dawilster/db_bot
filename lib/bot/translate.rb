require 'wit'
require 'date'

module Bot
  class Translate

    attr_accessor :response,
                  :when,
                  :table,
                  :mode,
                  :query

    def self.perform(*args)
      return new(*args).tap { |use_case| use_case.perform }
    end

    def initialize(message)
      @message = message
    end

    def perform
      init_wit_client

      construct_entities

      decide_mode

    rescue BotException => e
      @response = e.message
    end

    private

    def init_wit_client
      @client = Wit.new(access_token: ENV['WIT_ACCESS_KEY'])
    end

    def construct_entities
      translation = @client.message(@message)
      entities = translation['entities']

      @table = entities['table'][0]['value'] if entities['table']
      @query = entities['query'][0]['value'] if entities['query']
      @mode  = entities['mode'][0]['value'] if entities['mode']
      @when  = ::DateTime.parse(entities['datetime'][0]['value']) if entities['datetime']
    end

    def decide_mode
      case @mode
      when 'count'
        count_mode
      end
    end

    ## Modes

    def count_mode
      find_class

      if @when
        @response = @class.where('created_at >= ?', @when).length.to_s
      else
        @response = @class.length.to_s
      end
    end

    ## Helpers

    def find_class
      @class = @table.singularize.camelize.constantize

    rescue NameError
      raise BotException, 'Class cannot be found'
    end

    ## Our own exception
    class BotException < StandardError; end
  end
end