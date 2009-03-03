task :default => [:spec]
 
$gem_name = "biggs"
 
desc "Run specs"
task :spec do
  sh "spec spec/* --format specdoc --color"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = $gem_name
    s.summary = "biggs is a small ruby gem/rails plugin for formatting postal addresses from over 60 countries."
    s.email = "sebastian@yo.lk"
    s.homepage = "http://github.com/yolk/biggs"
    s.description = s.summary
    s.authors = ["Sebastian Munz"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end