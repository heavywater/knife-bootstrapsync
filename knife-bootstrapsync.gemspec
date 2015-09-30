$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__)) + '/lib/'
require 'knife-bootstrapsync/version'
Gem::Specification.new do |s|
  s.name = 'knife-bootstrapsync'
  s.version = Knife::Bootstrapsync::VERSION.version
  s.summary = 'Bootstrap directory sync'
  s.author = 'Chris Roberts'
  s.email = 'chrisroberts.code@gmail.com'
  s.homepage = 'https://github.com/heavywater/knife-bootstrapsync'
  s.description = 'Bootstrap directory sync'
  s.require_path = 'lib'
  s.add_dependency 'chef'
  s.add_dependency 'net-sftp'
  s.files = Dir['**/*']
end
