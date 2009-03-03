task :default => [:spec]
 
$gem_name = "biggs"
 
desc "Run specs"
task :spec do
  sh "spec spec/* --format specdoc --color"
end
 
desc "Build the gem"
task :build do
  sh "gem build #$gem_name.gemspec"
end
 
desc "Install the library at local machnie"
task :install => :build do
  sh "sudo gem install #$gem_name -l"
end
 
desc "Uninstall the library from local machnie"
task :uninstall do
  sh "sudo gem uninstall #$gem_name"
end
 
desc "Reinstall the library in the local machine"
task :reinstall => [:uninstall, :install] do
end
 
desc "Clean"
task :clean do
  sh "rm #$gem_name*.gem"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = $gem_name
    s.summary = "biggs is a small ruby tool to format postal addresses from over 60 countries. Use it as a standalone ruby gem or as a plugin for Rails."
    s.email = "sebastian@yo.lk"
    s.homepage = "http://github.com/yolk/biggs"
    s.description = s.summary
    s.authors = ["Sebastian Munz"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end