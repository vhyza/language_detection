module LanguageDetection

  class Language

    attr_accessor :name, :code, :reliable, :text_bytes, :details, :percent, :score

    def initialize(attributes = {})
      attributes.each_pair do |attribute, value|
        self.send("#{attribute}=", value)
      end

      @details ||= []
    end

  end

end
