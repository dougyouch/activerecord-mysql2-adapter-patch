# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'activerecord-mysql2-adapter-patch'
  s.version     = '6.0.2.2'
  s.licenses    = ['MIT']
  s.summary     = 'ActiveRecord Mysql2 Adapater batch for datetime on update'
  s.description = 'Fixes schema.rb for datetime fields that use on update'
  s.authors     = ['Doug Youch']
  s.email       = 'dougyouch@gmail.com'
  s.homepage    = 'https://github.com/dougyouch/activerecord-mysql2-adapter-patch'
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
end
