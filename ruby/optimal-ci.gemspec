require_relative 'lib/optimal/ci/version'

Gem::Specification.new do |spec|
  spec.name          = "optimal-ci"
  spec.version       = Optimal::CI::VERSION
  spec.authors       = ["Mohsen Alizadeh"]
  spec.email         = ["mohsen@alizadeh.us"]

  spec.summary       = "optimal-ci"
  spec.description   = "optimal-ci"
  spec.homepage      = "https://github.com/optimal-ci/optimal-ci"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/optimal-ci/optimal-ci"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency 'rest-client', '~> 2.1.0'
  spec.add_development_dependency 'faker', '~> 2.13.0'
end
