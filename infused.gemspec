require "./lib/infused/version"

Gem::Specification.new do |s|
  s.name = "infused"
  s.version = Infused::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Yi Wei"]
  s.email = ["yiwei.in.cyber@gmail.com"]
  s.summary = "Flyweight and self-contained Ruby DI"
  s.description = s.summary
  s.files = Dir.glob("lib/**/*") + %w(README.md LICENSE Rakefile)
  s.require_path = "lib"
end

