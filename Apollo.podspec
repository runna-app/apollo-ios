Pod::Spec.new do |spec|
  spec.name         = "Apollo"
  spec.version      = "0.0.3"
  spec.summary      = "Apollo iOS - A strongly-typed, caching GraphQL client for iOS"
  spec.description  = <<-DESC
                      Apollo iOS is a GraphQL client that generates Swift code from your GraphQL queries and mutations.
                      This version provides precompiled XCFrameworks for faster build times.
                      DESC
  
  spec.homepage     = "https://github.com/runna-app/apollo-ios"
  spec.license      = { :type => "MIT" }
  spec.author       = { "Runna" => "dev@runna.com" }
  
  spec.platform     = :ios, "15.0"
  spec.source       = { :git => "https://github.com/runna-app/apollo-ios.git", :tag => "#{spec.version}" }
  
  # Only vendor ApolloSQLite.xcframework which contains everything
  # (ApolloSQLite + Apollo + ApolloAPI all embedded)
  spec.vendored_frameworks = 'artifacts/ApolloSQLite.xcframework'
  spec.preserve_paths = 'artifacts/ApolloSQLite.xcframework'
  
  spec.frameworks = 'Foundation'
  spec.libraries = 'sqlite3'
end