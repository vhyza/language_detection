require "language_detection/version"
require "ffi"
require "hashr"

module LanguageDetection

  # TODO: Allow language hint
  #
  def self.perform(text, is_plain_text = false)
    result             = language_detection(text.to_s, is_plain_text)

    language           = parse_result(result, result.members - [:details])
    language[:details] = []

    details = FFI::Pointer.new(LanguageDetection::Detail, result[:details])
    3.times do |i|
      detail = parse_result(LanguageDetection::Detail.new(details[i]))
      language[:details] << detail unless detail.code == 'un'
    end

    language
  end

  def language(is_plain_text = false)
    LanguageDetection.perform(self.to_s, is_plain_text)
  end

  private

  def self.parse_result(result, members = result.members)
    Hashr.new(Hash[ members.map {|member| [member.to_sym, result[member]]} ])
  end

  extend FFI::Library

  class Detail < FFI::Struct
    layout :name,    :string,
           :code,    :string,
           :percent, :int,
           :score,   :double
  end

  class Language < FFI::Struct
    layout :name,       :string,
           :code,       :string,
           :reliable,   :bool,
           :text_bytes, :int,
           :details,    :pointer
  end

  ffi_lib File.expand_path("../../ext/cld/cld.so", __FILE__)
  attach_function "language_detection","language_detection", [:buffer_in, :bool], Language.by_value

end
