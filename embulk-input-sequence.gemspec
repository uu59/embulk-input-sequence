
Gem::Specification.new do |spec|
  spec.name          = "embulk-input-sequence"
  spec.version       = "0.1.0"
  spec.authors       = ["uu59"]
  spec.summary       = "Sequence input plugin for Embulk"
  spec.description   = "Loads records from Sequence."
  spec.email         = ["k@uu59.org"]
  spec.licenses      = ["MIT"]
  # TODO set this: spec.homepage      = "https://github.com/k/embulk-input-sequence"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  #spec.add_dependency 'YOUR_GEM_DEPENDENCY', ['~> YOUR_GEM_DEPENDENCY_VERSION']
  spec.add_development_dependency 'embulk', "~> 0.6.25"
  spec.add_development_dependency 'bundler', ['~> 1.0']
  spec.add_development_dependency 'rake', ['>= 10.0']
end
