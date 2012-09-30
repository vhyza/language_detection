# LanguageDetection

Ruby bindings for Chromium Compact Language Detector ([source](http://src.chromium.org/viewvc/chrome/trunk/src/third_party/cld/)). This gem is using source codes from [chromium-compact-language-detector](http://code.google.com/p/chromium-compact-language-detector/) port.

## Installation

Add this line to your application's Gemfile:

    gem 'language_detection'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install language_detection

## Usage

```ruby
>> require 'language_detection'
=> true
>> language = LanguageDetection.perform("This is some example text for language detection")
=> {:name=>"ENGLISH", :code=>"en", :reliable=>true, :text_bytes=>51, :details=>[{:name=>"ENGLISH", :code=>"en", :percent=>100, :score=>49.43273905996759}]}
>> language.name
=> "ENGLISH"
>> language.code
=> "en"
>> language.reliable
=> true
>> language.details # contains up to 3 languages sorted by score
=> [{:name=>"ENGLISH", :code=>"en", :percent=>100, :score=>49.43273905996759}]
>> language.details.first.percent
=> 100
>> language.details.first.score
=> 49.43273905996759
```

the other way is to include `LanguageDetection` module in your class

```ruby
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
```

which provides `Article#language` method using `Article#to_s` method as parameter

```ruby
>> article = Article.new :title => "Web development that doesn't hurt", :content => "Tens of thousands of Rails applications are already live..."
>> article.language
=> {:name=>"ENGLISH", :code=>"en", :reliable=>true, :text_bytes=>93, :details=>[{:name=>"ENGLISH", :code=>"en", :percent=>100, :score=>80.22690437601297}]}
```

or you can add `String#language` method by `require 'language_detection/string'`

```ruby
>> require 'language_detection'
=> true
>> require 'language_detection/string'
=> true
>> "Web development that doesn't hurt".language
=> {:name=>"ENGLISH", :code=>"en", :reliable=>true, :text_bytes=>36, :details=>[{:name=>"ENGLISH", :code=>"en", :percent=>100, :score=>39.70826580226905}]}
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
