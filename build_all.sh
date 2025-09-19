#!/bin/bash

# Universal Build Script for ESP32 Controller
# Builds for both Linux and Windows (if on Windows with WSL)

set -e

echo "🚀 Building ESP32 Controller for all platforms..."

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Detect platform
PLATFORM=$(uname -s)
print_status "Detected platform: $PLATFORM"

# Build for Linux
print_status "Building for Linux..."
chmod +x build_linux.sh
./build_linux.sh

# Build for Windows (if on Linux with WSL or if wine is available)
if command -v wine &> /dev/null; then
    print_status "Building for Windows using Wine..."
    # This would require additional setup for Wine + Python on Wine
    print_warning "Windows build via Wine not implemented yet. Please use Windows machine or WSL."
else
    print_warning "Wine not available. Skipping Windows build."
    print_status "To build for Windows, run build_windows.bat on a Windows machine."
fi

print_success "🎉 Build process completed!"
print_status "Linux executable: build/linux/dist/ESP32Controller"
print_status "To build for Windows, copy the project to Windows and run build_windows.bat"
