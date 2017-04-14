require 'wit'
require 'date'

module DbBot
  class Translate

    attr_accessor :response,
                  :when,
                  :table,
                  :verb,
                  :query,
                  :number,
                  :collection

    def self.perform(*args)
      return new(*args).tap { |use_case| use_case.perform }
    end

    def initialize(message)
      @message = message
    end

    def perform
      init_wit_client

      construct_entities

      process_verb

    rescue TranslateException => e
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
      @verb  = entities['verb'][0]['value'] if entities['verb']
      @when  = ::DateTime.parse(entities['datetime'][0]['value']) if entities['datetime']
      @number  = entities['number'][0]['value'] if entities['number']
    end

    def process_verb
      case @verb
      when 'count'
        if @table && @query
          return count_verb
        end
      when 'return'
        return return_verb
      end

      @response = "Please try again"
    end

    ## Verbs

    def count_verb
      find_class

      if @when
        @response = @class.where('created_at >= ?', @when).size.to_s
      else
        @response = @class.all.size.to_s
      end
    end

    def return_verb
      find_class

      @collection = @class.limit(@number || 100)

      if @collection.any?
        @response = 'There you go'
      else
        @response = "There weren't any #{@table}"
      end
    end

    ## Helpers

    def find_class
      @class = @table.singularize.camelize.constantize

    rescue NameError
      raise TranslateException, 'Class cannot be found'
    end

    ## Our own exception
    class TranslateException < StandardError; end
  end
end