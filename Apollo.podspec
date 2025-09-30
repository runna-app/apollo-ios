Pod::Spec.new do |spec|
  spec.name         = "Apollo"
  spec.version      = "0.0.3"
  spec.summary      = "Apollo iOS XCFrameworks"
  spec.description  = "Precompiled Apollo iOS frameworks for GraphQL client"
  
  spec.homepage     = "https://github.com/runna-app/apollo-ios"
  spec.license      = { :type => "MIT" }
  spec.author       = { "Runna" => "dev@runna.com" }
  
  spec.platform     = :ios, "17.0"
  spec.watchos.deployment_target = "11.0"
  
  spec.source       = { :git => "https://github.com/runna-app/apollo-ios.git", :tag => "#{spec.version}" }
  
  # Default subspec includes core Apollo + ApolloAPI
  spec.default_subspecs = 'Core'
  
  # ApolloAPI - Base types and protocols
  spec.subspec 'ApolloAPI' do |api|
    api.vendored_frameworks = 'artifacts/ApolloAPI.xcframework'
    api.frameworks = 'Foundation'
  end
  
  # Core Apollo - GraphQL client (depends on ApolloAPI)
  spec.subspec 'Core' do |core|
    core.vendored_frameworks = 'artifacts/Apollo.xcframework'
    core.dependency 'Apollo/ApolloAPI'
    core.frameworks = 'Foundation'
  end
  
  # SQLite - Normalized cache (depends on Core)
  spec.subspec 'SQLite' do |sqlite|
    sqlite.vendored_frameworks = 'artifacts/ApolloSQLite.xcframework'
    sqlite.dependency 'Apollo/Core'
    sqlite.libraries = 'sqlite3'
  end
end
