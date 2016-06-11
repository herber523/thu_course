# ThuCourse

快速獲取東海大學開課明細
資料來源為 course.thu.edu.tw 這個網站

## 安裝

加入這行到您的 Gemfile:

```ruby
gem 'thu_course'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thu_course

## 使用

取得所有開課明細
```ruby
	ThuCourse.all(105,1)
	# 參數為 學年 學期
```
取得系所編號
```ruby
	ThuCourse.department_id(105,1)
	# 參數為 學年 學期
```
取得系所開課明細
```ruby
	ThuCourse.department_id(105,1,'100')
	# 參數為 學年 學期 系所編號
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/thu_course.

