Pod::Spec.new do |s|
  s.name         = "Agent"
  s.version      = "0.0.2"
  s.summary      = "Minimalistic Swift HTTP request agent for iOS and OS X"
  s.homepage     = "https://github.com/hallas/agent"
  s.license      = 'MIT'
  s.author       = { "hallas" => "christoffer.hallas@gmail.com" }
  s.source       = { :git => "https://github.com/hallas/agent.git", :tag => "#{s.version}" }
  s.platform     = :ios, '6.1'
  s.source_files = 'Agent/*.swift'
  s.frameworks   = 'Foundation'
  s.requires_arc = true
end
