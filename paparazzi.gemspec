lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "paparazzi/version"

Gem::Specification.new do |spec|
  spec.name          = "paparazzi"
  spec.version       = Paparazzi::VERSION
  spec.authors       = ["Robin Clart"]
  spec.email         = ["robin@omise.co"]

  spec.summary       = "Take screenshots and upload them to S3"
  spec.homepage      = "https://www.omise.co/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "watir"
  spec.add_dependency "aws-sdk-s3"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
