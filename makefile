default: unpack-cli

unpack-cli:
	(cd CLI && tar -xvf apollo-ios-cli.tar.gz -C ../)
	chmod +x apollo-ios-cli

xcframeworks:
	@echo "📦 Building XCFrameworks for Apollo, ApolloAPI, and ApolloSQLite..."
	@# Backup original Package.swift
	@cp Package.swift Package.swift.backup
	@# Build Apollo
	@echo "🔧 Configuring Package.swift for Apollo..."
	@sed -i '' 's/.library(name: "Apollo", targets: \["Apollo"\])/.library(name: "Apollo", type: .dynamic, targets: ["Apollo"])/' Package.swift
	./make_xcframework.sh Apollo
	@cp Package.swift.backup Package.swift
	@# Build ApolloAPI
	@echo "🔧 Configuring Package.swift for ApolloAPI..."
	@sed -i '' 's/.library(name: "ApolloAPI", targets: \["ApolloAPI"\])/.library(name: "ApolloAPI", type: .dynamic, targets: ["ApolloAPI"])/' Package.swift
	./make_xcframework.sh ApolloAPI
	@cp Package.swift.backup Package.swift
	@# Build ApolloSQLite
	@echo "🔧 Configuring Package.swift for ApolloSQLite..."
	@sed -i '' 's/.library(name: "ApolloSQLite", targets: \["ApolloSQLite"\])/.library(name: "ApolloSQLite", type: .dynamic, targets: ["ApolloSQLite"])/' Package.swift
	./make_xcframework.sh ApolloSQLite
	@# Restore original Package.swift
	@cp Package.swift.backup Package.swift
	@rm Package.swift.backup
	@echo "✅ All XCFrameworks built successfully!"
