Gem::Specification.new do |s|  
  s.name        = 'fetchapp'  
  s.version     = '2.3.0'  
  s.date        = '2015-05-11'
  s.executables = %w{ fetchapp }  
  s.summary     = "fetch app"  
  s.description = "fetch apple app"  
  s.authors     = ["chengkai"]  
  s.email       = 'chengkai@1853.com'  
  s.files       = Dir["lib/*"]  +%w{ bin/fetchapp}
  s.require_paths = %w{ lib }
  s.homepage    = 'http://rubygems.org/gems/fetchapp'  
end  
