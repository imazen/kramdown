# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name = "kramdown"
  s.version = Kramdown::VERSION
  s.author = 'Thomas Leitner'
  s.email = 't_leitner@gmx.at'
  s.homepage = "http://kramdown.gettalong.org"
  s.rubyforge_project = 'kramdown'

  s.description = <<EOF
kramdown is yet-another-markdown-parser but fast, pure Ruby,
using a strict syntax definition and supporting several common extensions.
EOF
  s.summary = 'kramdown is a fast, pure-Ruby Markdown-superset converter.'
  s.license = 'MIT'

  s.require_paths = ["lib"]
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,specs,features}/*`.split("\n")
  s.default_executable = 'kramdown'
  s.executables = ['kramdown']

  s.has_rdoc = true
  s.rdoc_options = ['--main', 'lib/kramdown/document.rb']
end
