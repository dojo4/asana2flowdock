## asana2flowdock.gemspec
#

Gem::Specification::new do |spec|
  spec.name = "asana2flowdock"
  spec.version = "1.3.0"
  spec.platform = Gem::Platform::RUBY
  spec.summary = "asana2flowdock"
  spec.description = "asana2flowdock relays asana events into flowdock awesomely"
  spec.license = "same as ruby's"

  spec.files =
["Gemfile",
 "Gemfile.lock",
 "README.md",
 "Rakefile",
 "asana2flowdock.gemspec",
 "bin",
 "bin/asana2flowdock",
 "config",
 "lib",
 "lib/asana2flowdock",
 "lib/asana2flowdock.rb",
 "lib/asana2flowdock/asana.rb",
 "lib/asana2flowdock/slug.rb"]

  spec.executables = ["asana2flowdock"]
  
  spec.require_path = "lib"

  spec.test_files = nil

  
    spec.add_dependency(*["arrayfields", "~> 4.7.4"])
  
    spec.add_dependency(*["main", "~> 6.1.0"])
  
    spec.add_dependency(*["pry", "~> 0.10.1"])
  
    spec.add_dependency(*["pry-debugger", "~> 0.2.3"])
  
    spec.add_dependency(*["pry-nav", "~> 0.2.4"])
  
    spec.add_dependency(*["stringex", ">= 2.1.0"])
  
    spec.add_dependency(*["amalgalite"])
  
    spec.add_dependency(*["sequel"])
  
    spec.add_dependency(*["json"])
  
    spec.add_dependency(*["map"])
  
    spec.add_dependency(*["coerce"])
  
    spec.add_dependency(*["fattr"])
  
    spec.add_dependency(*["threadify"])
  
    spec.add_dependency(*["flowdock"])
  

  spec.extensions.push(*[])

  spec.rubyforge_project = "codeforpeople"
  spec.author = "Ara T. Howard"
  spec.email = "ara.t.howard@gmail.com"
  spec.homepage = "https://github.com/ahoward/asana2flowdock"
end
