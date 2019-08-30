# encoding: utf-8

require './test/_helper'
require 'csv'

class LanguageDetectionTest < Test::Unit::TestCase

  context "Language detection" do

    should "be able to convert result from native call to Language instance" do
      result        = LanguageDetection.language_detection("this is some text", false)
      parsed_result = LanguageDetection.parse_result(result)

      assert_kind_of LanguageDetection::LanguageStruct, result
      assert_kind_of LanguageDetection::Language, parsed_result

      assert_equal "english", parsed_result.name
    end

    should "convert details from FFI pointer to Language instance" do
      language = LanguageDetection.perform("this is some text")

      assert_kind_of Array,                       language.details
      assert_kind_of LanguageDetection::Language, language.details.first
      assert_equal "english",                     language.details.first.name
      assert_equal 65,                            language.details.first.percent
    end

    should "recognize languages in testing data" do
      CSV.foreach(File.expand_path("../fixtures/languages.csv", __FILE__), :quote_char => '"') do |row|
        assert_equal row[0], LanguageDetection.perform(row[1]).code
      end
    end

  end

  context "When LanguageDetection module is included" do
    class Article
      include LanguageDetection

      attr_accessor :title, :content

      def initialize(params = {})
        @title   = params[:title]
        @content = params[:content]
      end

      def to_s
        "#{title}\n#{content}"
      end
    end

    setup do
      @article = Article.new :title => "Web development that doesn't hurt", :content => "Tens of thousands of Rails applications are already live. People are using Rails in the tiniest part-time operations to the biggest companies."
    end

    should "provide Model#language instance method" do
      assert @article.respond_to?(:language)
    end

    should "call LanguageDetection.perform with Model#to_s as parameter when calling Model#language" do
      LanguageDetection.expects(:perform).with("#{@article.title}\n#{@article.content}", false)

      @article.language
    end

    should "return detected language" do
      language = @article.language
      assert_equal "english", language.name
      assert_equal true,      language.reliable
      assert_equal 100,       language.details.first.percent
    end

  end

  context "Include LanguageDetection to string" do

    should "have String#language method" do
      assert ! "some string".respond_to?(:language)
      require 'language_detection/string'
      assert "some string".respond_to?(:language)
    end

  end


end
