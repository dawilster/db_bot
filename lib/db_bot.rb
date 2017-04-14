require "db_bot/version"
require "db_bot/translate"

module DbBot
  def self.message(message)
    Translate.perform(message)
  end
end
