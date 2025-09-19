#!/bin/bash

# ESP32 Controller Build Script for Linux/Ubuntu
# This script creates a standalone executable for Linux

set -e  # Exit on any error

echo "�� Building ESP32 Controller for Linux..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    print_error "Python 3 is not installed. Please install Python 3.8 or higher."
    exit 1
fi

# Check Python version
PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
print_status "Found Python $PYTHON_VERSION"

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    print_error "pip3 is not installed. Please install pip3."
    exit 1
fi

# Create virtual environment
print_status "Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Upgrade pip
print_status "Upgrading pip..."
pip install --upgrade pip

# Install requirements
print_status "Installing Python dependencies..."
pip install -r requirements.txt

# Install esptool
print_status "Installing esptool..."
pip install esptool

# Create build directory
print_status "Creating build directory..."
mkdir -p build/linux
cd build/linux

# Build with PyInstaller
print_status "Building executable with PyInstaller..."
pyinstaller \
    --onefile \
    --windowed \
    --name "ESP32Controller" \
    --icon=../../icon.ico \
    --add-data "../../requirements.txt:." \
    --hidden-import PyQt6.QtCore \
    --hidden-import PyQt6.QtGui \
    --hidden-import PyQt6.QtWidgets \
    --hidden-import serial \
    --hidden-import requests \
    --hidden-import packaging \
    --hidden-import esptool \
    --clean \
    ../../esp32_controller.py

# Check if build was successful
if [ -f "dist/ESP32Controller" ]; then
    print_success "Build completed successfully!"
    print_status "Executable created: build/linux/dist/ESP32Controller"
    
    # Make executable
    chmod +x dist/ESP32Controller
    
    # Create a simple launcher script
    cat > dist/run_esp32_controller.sh << 'EOF'
#!/bin/bash
# ESP32 Controller Launcher
# This script ensures all dependencies are available

echo "🚀 Starting ESP32 Controller..."

# Check if esptool is available
if ! command -v esptool &> /dev/null; then
    echo "⚠️  esptool not found in PATH. Installing via pip..."
    pip3 install esptool --user
fi

# Run the application
./ESP32Controller
EOF
    
    chmod +x dist/run_esp32_controller.sh
    
    print_success "Created launcher script: build/linux/dist/run_esp32_controller.sh"
    
    # Create README for the build
    cat > dist/README.txt << 'EOF'
ESP32 Hand Controller Configuration Tool
========================================

This is a standalone executable for Linux/Ubuntu.

Requirements:
- Python 3.8 or higher (for esptool if not already installed)
- USB serial port access (user should be in dialout group)

Installation:
1. Make sure you're in the dialout group: sudo usermod -a -G dialout $USER
2. Log out and log back in
3. Run: ./run_esp32_controller.sh

Or run directly: ./ESP32Controller

Features:
- Configure ESP32 hand controller settings
- Flash firmware
- Real-time serial communication
- Modern Qt6 GUI

For support, visit: https://github.com/georgebenett/gb_remote
EOF
    
    print_success "Build package ready in: build/linux/dist/"
    print_status "Files created:"
    ls -la dist/
    
else
    print_error "Build failed! Check the output above for errors."
    exit 1
fi

print_success "�� Linux build completed successfully!"
