# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'SudokuCSP/version'

Gem::Specification.new do |spec|
  spec.name          = "SudokuCSP"
  spec.version       = SudokuCSP::VERSION
  spec.authors       = ["Whatisinternet"]
  spec.email         = ["joshteeter@gmail.com"]

  spec.summary       = %q{Sudoku CSP solver}
  spec.homepage      = "https://githbub.com/whatisinternet/SudokuCSP-rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "rspec-expectations", "~> 3"
  spec.add_development_dependency "rspec-nc", "~> 0.2"
  spec.add_development_dependency "guard", "~> 2.12"
  spec.add_development_dependency "guard-rspec", "~> 4.5"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-remote", "~> 0.1"
  spec.add_development_dependency "pry-nav", "~> 0.2"
end
