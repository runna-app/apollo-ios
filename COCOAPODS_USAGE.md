# Apollo iOS - CocoaPods Usage Guide

Single podspec with subspecs for flexible installation.

## 📦 Installation Options

The `Apollo.podspec` provides three subspecs you can choose from:

### Option 1: Default (SQLite) - Recommended

Installs everything including SQLite caching support:

```ruby
pod 'Apollo'
```

This is equivalent to:
```ruby
pod 'Apollo/SQLite'
```

**Includes:**
- ✅ ApolloSQLite.xcframework
- ✅ Apollo.xcframework (via dependency)
- ✅ ApolloAPI.xcframework (via dependency)

### Option 2: Core Client Only

If you don't need SQLite caching:

```ruby
pod 'Apollo/Core'
```

**Includes:**
- ✅ Apollo.xcframework
- ✅ ApolloAPI.xcframework (via dependency)

### Option 3: API Types Only

If you only need the GraphQL type system:

```ruby
pod 'Apollo/API'
```

**Includes:**
- ✅ ApolloAPI.xcframework only

---

## 🚀 Quick Start

### For Local Development:

**Podfile:**
```ruby
target 'YourApp' do
  use_frameworks!
  
  # Local path
  pod 'Apollo', :path => '../apollo-ios'
end
```

### For Remote Repository:

**Podfile:**
```ruby
target 'YourApp' do
  use_frameworks!
  
  # From git repo
  pod 'Apollo', :git => 'https://github.com/runna-app/apollo-ios.git', :tag => '0.0.1'
  
  # Or a specific branch
  # pod 'Apollo', :git => 'https://github.com/runna-app/apollo-ios.git', :branch => 'main'
end
```

### Install:

```bash
pod install
open YourApp.xcworkspace
```

---

## 💻 Usage in Your Code

### With SQLite (Default):

```swift
import ApolloAPI
import Apollo        // Note: Not Apollo_Core
import ApolloSQLite

// Setup SQLite cache
let documentsPath = NSSearchPathForDirectoriesInDomains(
    .documentDirectory,
    .userDomainMask,
    true
).first!
let documentsURL = URL(fileURLWithPath: documentsPath)
let sqliteFileURL = documentsURL.appendingPathComponent("apollo_cache.sqlite")

let cache = try! SQLiteNormalizedCache(fileURL: sqliteFileURL)
let store = ApolloStore(cache: cache)

// Create Apollo client
let client = ApolloClient(
    networkTransport: RequestChainNetworkTransport(
        interceptorProvider: DefaultInterceptorProvider(
            store: store,
            client: URLSessionClient()
        ),
        endpointURL: URL(string: "https://your-api.com/graphql")!
    ),
    store: store
)
```

### With Core Only (No SQLite):

```swift
import ApolloAPI
import Apollo

// In-memory cache only
let store = ApolloStore()

let client = ApolloClient(
    networkTransport: RequestChainNetworkTransport(
        interceptorProvider: DefaultInterceptorProvider(
            store: store,
            client: URLSessionClient()
        ),
        endpointURL: URL(string: "https://your-api.com/graphql")!
    ),
    store: store
)
```

---

## ✅ How This Solves the Duplicate Symbol Issue

### The Problem:
Each XCFramework contains embedded dependencies:
- `ApolloSQLite.xcframework` → 1.7 MB (contains everything)
- `Apollo.xcframework` → 1.6 MB (contains Apollo + ApolloAPI)
- `ApolloAPI.xcframework` → 516 KB (just ApolloAPI)

### The Solution:
The subspec dependencies tell CocoaPods the relationship:

```
Apollo/SQLite
    ↓ depends on
Apollo/Core
    ↓ depends on
Apollo/API
```

**CocoaPods automatically:**
- ✅ Includes all required frameworks
- ✅ Merges duplicate symbols at link time
- ✅ Eliminates runtime warnings

---

## 📊 Subspec Comparison

| Subspec | Command | Size | Use When |
|---------|---------|------|----------|
| **SQLite** (default) | `pod 'Apollo'` | 1.7 MB | You need persistent caching |
| **Core** | `pod 'Apollo/Core'` | 1.6 MB | You only need in-memory cache |
| **API** | `pod 'Apollo/API'` | 516 KB | You only need type definitions |

---

## 🔄 Updating

### From Local Path:
```bash
cd apollo-ios
make xcframeworks

cd ../YourApp
pod update Apollo
```

### From Remote Git:
```bash
cd YourApp
pod update Apollo
```

---

## 🎯 Advanced Usage

### Multiple Targets:

```ruby
target 'YourApp' do
  use_frameworks!
  pod 'Apollo'  # Full Apollo with SQLite
end

target 'YourAppTests' do
  use_frameworks!
  pod 'Apollo/Core'  # Just core client for tests
end

target 'YourFramework' do
  use_frameworks!
  pod 'Apollo/API'  # Just types for a framework
end
```

### Version Locking:

```ruby
# Specific version
pod 'Apollo', '0.0.1', :git => 'https://github.com/runna-app/apollo-ios.git'

# Optimistic operator (~>)
pod 'Apollo', '~> 0.0.1'

# Exact tag
pod 'Apollo', :git => 'https://github.com/runna-app/apollo-ios.git', :tag => 'v0.0.1'
```

---

## 🆘 Troubleshooting

### Still seeing duplicate symbols?

Make sure you're using the subspecs correctly:

```ruby
# ❌ Wrong - don't mix subspecs
pod 'Apollo'
pod 'Apollo/Core'  # This creates duplicates!

# ✅ Correct - choose ONE
pod 'Apollo'  # OR pod 'Apollo/SQLite'
```

### "Unable to find specification"

For remote repos, ensure the podspec is in the repo root and the tag exists:
```bash
git tag -a 0.0.1 -m "Release 0.0.1"
git push --tags
```

### Clean build:

```bash
pod deintegrate
pod cache clean Apollo --all
pod install
```

---

## 📚 Documentation Files

- `COCOAPODS_USAGE.md` (this file) - Complete usage guide
- `README_PODSPECS.md` - Overview of the setup
- `PODSPECS_USAGE.md` - Legacy separate podspecs guide
- `XCFRAMEWORK_USAGE.md` - XCFramework build instructions

---

## ✅ Summary

**One podspec, three subspecs, flexible installation!**

```ruby
# Default (everything)
pod 'Apollo'

# Or choose what you need
pod 'Apollo/Core'  # Client only
pod 'Apollo/API'   # Types only
```

Works perfectly for both local and remote repositories! 🎉
