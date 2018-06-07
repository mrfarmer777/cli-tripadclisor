
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tripadCLIsor/version"

Gem::Specification.new do |spec|
  spec.name          = "tripadCLIsor"
  spec.version       = TripadCLIsor::VERSION
  spec.authors       = ["'Matt Farmer'"]
  spec.email         = ["'mrfarmer777@gmail.com'"]

  spec.summary       = %q{A simple CLI program to help find you a hotel in the destination of your dreams.}
  spec.description   = %q{Need a little inspiration for your next trip, but you're tired of all the dizzying colors and non-serifed fonts of the modern web? Try getting inspired in the familiar comfort of the Command Line with TripadCLIsor! Choose from over 700 destinations serendipitously selected for you or be inspired by themed destinations that strike your fancy.}
  spec.homepage      = "https://github.com/mrfarmer777/cli-tripadclisor"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   << 'tripadclisor'#spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10.3"
  spec.add_development_dependency "nokogiri", "~> 1.8",">=1.8.2"

end
