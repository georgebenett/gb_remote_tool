#!/bin/bash

# Main build script for ESP32 Controller
# This is the entry point for building the application

set -e

echo "🚀 ESP32 Controller Build System"
echo "================================"

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

# Check if we're in the right directory
if [ ! -f "esp32_controller.py" ]; then
    echo "Error: esp32_controller.py not found. Please run this script from the project directory."
    exit 1
fi

# Create icon if it doesn't exist
if [ ! -f "icon.ico" ]; then
    print_status "Creating application icon..."
    python3 create_icon.py
fi

# Make scripts executable
chmod +x build_linux.sh
chmod +x build_all.sh
chmod +x install.sh

# Show menu
echo ""
echo "What would you like to do?"
echo "1. Setup dependencies (first time only)"
echo "2. Build for Linux"
echo "3. Build for Windows (requires Windows machine)"
echo "4. Build for all platforms"
echo "5. Run the application directly"
echo "6. Exit"
echo ""

read -p "Enter your choice (1-6): " choice

case $choice in
    1)
        print_status "Setting up dependencies..."
        ./install.sh
        ;;
    2)
        print_status "Building for Linux..."
        ./build_linux.sh
        ;;
    3)
        print_warning "Windows build requires a Windows machine."
        print_status "Please copy this project to Windows and run build_windows.bat"
        ;;
    4)
        print_status "Building for all platforms..."
        ./build_all.sh
        ;;
    5)
        print_status "Running application directly..."
        python3 esp32_controller.py
        ;;
    6)
        print_status "Goodbye!"
        exit 0
        ;;
    *)
        print_error "Invalid choice. Please run the script again."
        exit 1
        ;;
esac

print_success "Operation completed!"
