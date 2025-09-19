#!/bin/bash

# ESP32 Controller Installation Script
# This script sets up the complete build environment

set -e

echo "🚀 ESP32 Controller - Complete Setup"
echo "===================================="

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
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

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "esp32_controller.py" ]; then
    print_error "esp32_controller.py not found. Please run this script from the project directory."
    exit 1
fi

print_status "Setting up ESP32 Controller build environment..."

# Make all scripts executable
print_status "Making scripts executable..."
chmod +x *.sh 2>/dev/null || true
chmod +x build_windows.bat 2>/dev/null || true

# Create icon
if [ ! -f "icon.ico" ]; then
    print_status "Creating application icon..."
    python3 create_icon.py
fi

# Setup dependencies
print_status "Setting up dependencies..."

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    print_error "Python 3 is not installed. Please install Python 3.8 or higher."
    exit 1
fi

# Check if venv module is available
if ! python3 -m venv --help &> /dev/null; then
    print_error "python3-venv is not installed. Please install it with:"
    print_error "sudo apt install python3-venv"
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    print_status "Creating virtual environment..."
    python3 -m venv venv
else
    print_status "Virtual environment already exists, using existing one..."
fi

# Activate virtual environment
print_status "Activating virtual environment..."
source venv/bin/activate

# Upgrade pip
print_status "Upgrading pip..."
pip install --upgrade pip

# Install required packages
print_status "Installing Python dependencies..."
pip install -r requirements.txt

print_success "Dependencies installed successfully!"

print_success "🎉 Setup completed successfully!"
echo ""
echo "Next steps:"
echo "1. Run './build.sh' to build executables"
echo "2. Or run 'source venv/bin/activate && python esp32_controller.py' to run directly"
echo ""
echo "For Windows users:"
echo "1. Copy this entire folder to Windows"
echo "2. Run 'build_windows.bat'"
echo ""
print_success "Ready to go! 🚀"
