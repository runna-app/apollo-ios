Pod::Spec.new do |spec|
  spec.name         = "Apollo"
  spec.version      = "0.0.1"
  spec.summary      = "Apollo iOS XCFrameworks"
  spec.description  = "Precompiled Apollo iOS frameworks for GraphQL client"
  
  spec.homepage     = "https://github.com/runna-app/apollo-ios"
  spec.license      = { :type => "MIT" }
  spec.author       = { "Runna" => "dev@runna.com" }
  
  spec.platform     = :ios, "15.0"
  
  spec.source       = { :path => "." }
  
  spec.vendored_frameworks = [
    'artifacts/Apollo.xcframework',
    'artifacts/ApolloSQLite.xcframework',
    'artifacts/ApolloAPI.xcframework',
  ]
  
  # Ensure the frameworks are preserved during installation
  spec.preserve_paths = [
    'artifacts/Apollo.xcframework',
    'artifacts/ApolloSQLite.xcframework',
    'artifacts/ApolloAPI.xcframework',
  ]
  
  # Add any required system frameworks
  spec.frameworks = 'Foundation'
end
