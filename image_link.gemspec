# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "image_link/version"

Gem::Specification.new do |s|
  s.name        = "image_link"
  s.version     = ImageLink::VERSION
  s.authors     = ["ecoologic"]
  s.email       = ["erikecoologic@gmail.com"]
  s.homepage    = "https://github.com/ecoologic/image_link"
  s.summary     = %q{An image with a link}
  s.description = %q{Provides an image with a link, and a lot of options...}

  s.rubyforge_project = "image_link"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
