Gem::Specification.new do |s|  
  s.name        = 'ptinstall'  
  s.version     = '0.0.1'  
  s.date        = '2015-05-11'
  s.executables = %w{ ptinstall }  
  s.summary     = "fetch app"  
  s.description = "fetch apple app"  
  s.authors     = ["chengkai"]  
  s.email       = 'chengkai@1853.com'  
  s.files       = Dir["lib/*"]  +%w{ bin/ptinstall}
  s.require_paths = %w{ lib }
  s.homepage    = 'http://rubygems.org/gems/ptinstall'  
end  
