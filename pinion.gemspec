Gem::Specification.new do |spec|
  spec.name		= "pinion"
  spec.version		= "0.0.1"
  author_list = { 
    "Judson Lester" => "nyarly@gmail.com"
  }
  spec.authors		= author_list.keys
  spec.email		= spec.authors.map {|name| author_list[name]}
  spec.summary		= "An extension for Rack"
  spec.description	= <<-EndDescription
  EndDescription

  spec.rubyforge_project= spec.name.downcase
  spec.homepage        = "http://#{spec.rubyforge_project}.rubyforge.org/"
  spec.required_rubygems_version = Gem::Requirement.new(">= 0") if spec.respond_to? :required_rubygems_version=

  spec.files		= %w[
    lib/rack/and-pinion.rb
    lib/pinion.rb
    lib/pinion/chain.rb
    lib/pinion/and-rack.rb
    lib/pinion/transaction.rb
    lib/pinion/step.rb
    doc/README
    spec_help/spec_helper.rb
    spec_help/gem_test_suite.rb
    spec_help/ungemmer.rb
    spec_help/file-sandbox.rb
  ]


  spec.test_file        = "spec_help/gem_test_suite.rb"
  spec.licenses = ["MIT"]
  spec.require_paths = %w[lib/]
  spec.rubygems_version = "1.3.5"
  
  dev_deps = [
    ["rake-rubygems", ">= 0.2.0"],
    ["hanna", "~> 0.1.0"],
    ["mailfactory", "~> 1.4.0"],
    ["rspec", [">= 2.0"]],
    ["bundler", ["~> 1.0.0"]],
    ["rcov", [">= 0"]],
    ["nokogiri", [">= 0"]]
  ]
  if spec.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    spec.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      dev_deps.each do |gem, versions|
        spec.add_development_dependency(gem, versions)
      end
    else
      dev_deps.each do |gem, versions|
        spec.add_dependency(gem, versions)
      end
    end
  else
    dev_deps.each do |gem, versions|
      spec.add_dependency(gem, versions)
    end
  end
  spec.has_rdoc		= true
  spec.extra_rdoc_files = Dir.glob("doc/**/*")
  spec.rdoc_options	= %w{--inline-source }
  spec.rdoc_options	+= %w{--main doc/README }
  spec.rdoc_options	+= ["--title", "#{spec.name}-#{spec.version} RDoc"]

  spec.add_dependency("rack", ">= 1.0.1")

  spec.post_install_message = "Another tidy package brought to you by Judson"
end


