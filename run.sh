#!/bin/bash

# AuraGrids - Quick Run Script
# This script runs the Flutter app with optimal settings

echo "🌟 Starting AuraGrids..."
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Error: Flutter is not installed or not in PATH"
    echo "Please install Flutter: https://docs.flutter.dev/get-started/install"
    exit 1
fi

# Check Flutter version
echo "📦 Flutter version:"
flutter --version | head -1
echo ""

# Prompt user for mode
echo "Choose run mode:"
echo "1) Debug mode (hot reload, slower, shows warnings)"
echo "2) Release mode (fast, no warnings) - RECOMMENDED"
echo ""
read -p "Enter choice [1-2]: " choice

case $choice in
    1)
        echo ""
        echo "🔧 Running in DEBUG mode..."
        echo "⚠️  Note: You may see harmless pointer binding warnings"
        echo "⚠️  First load may take 10-15 seconds"
        echo ""
        flutter run -d chrome
        ;;
    2)
        echo ""
        echo "🚀 Running in RELEASE mode..."
        echo "✅ Fast loading, no warnings"
        echo "❌ No hot reload available"
        echo ""
        flutter run -d chrome --release
        ;;
    *)
        echo "Invalid choice. Running in release mode..."
        flutter run -d chrome --release
        ;;
esac
