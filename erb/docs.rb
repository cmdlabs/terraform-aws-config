require "erb"

docs = {
  "erb/README.erb"          => "README.md",
  "erb/examples_README.erb" => "examples/README.md",
}

docs.each do |erb,md|
  template = File.read(erb)
  renderer = ERB.new(template, nil, "-")
  File.write(md, renderer.result())
end
