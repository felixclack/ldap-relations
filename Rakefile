require "bundler/gem_tasks"

task :travis do
  puts "Starting to run rspec spec"
  system "bundle exec rspec spec"
  raise "rspec spec failed!" unless $?.exitstatus == 0
end
