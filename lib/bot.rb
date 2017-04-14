require "bot/version"
require "bot/translate"

module Bot
  def self.message(message)
    Translate.perform(message)
  end
end
