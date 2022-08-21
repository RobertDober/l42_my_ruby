require_relative "lib/l42/version"
version = L42::Version::VERSION

description = <<~DESCRIPTION
  All my Ruby Code

  Binaries and libs which make Ruby awesome (for me)
DESCRIPTION

Gem::Specification.new do |s|
  s.name        = 'l42_my_ruby'
  s.version     = version
  s.summary     = 'All my Ruby Code'
  s.description = description
  s.authors     = ["Robert Dober"]
  s.email       = 'robert.dober@gmail.com'
  s.files       = Dir.glob("lib/**/*.rb")
  s.files      += %w[LICENSE README.md]
  s.homepage    = "https://github.com/robertdober/l42_my_ruby"
  s.licenses    = %w[Apache-2.0]

  s.required_ruby_version = '>= 3.1.0'
end
