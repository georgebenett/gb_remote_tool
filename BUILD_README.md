# ESP32 Controller Build System

This directory contains everything needed to build standalone executables for the ESP32 Hand Controller Configuration Tool.

## Quick Start

1. **First time setup:**
   ```bash
   chmod +x *.sh
   ./build.sh
   # Choose option 1 to setup dependencies
   ```

2. **Build for your platform:**
   ```bash
   ./build.sh
   # Choose option 2 for Linux or option 3 for Windows
   ```

## Files Overview

- `esp32_controller.py` - Main application
- `requirements.txt` - Python dependencies
- `build.sh` - Main build script (interactive menu)
- `build_linux.sh` - Builds Linux executable
- `build_windows.bat` - Builds Windows executable
- `build_all.sh` - Builds for all platforms
- `create_icon.py` - Creates application icon

## Dependencies

### System Requirements
- **Linux/Ubuntu:** Python 3.8+, pip, build-essential
- **Windows:** Python 3.8+, pip
- **macOS:** Python 3.8+, Homebrew

### Python Dependencies
- PyQt6 (GUI framework)
- pyserial (serial communication)
- requests (HTTP requests)
- packaging (version comparison)
- pyinstaller (executable creation)
- esptool (ESP32 flashing)

## Building Executables

### Linux/Ubuntu
```bash
./build_linux.sh
```
Creates: `build/linux/dist/ESP32Controller`

### Windows
```bash
build_windows.bat
```
Creates: `build/windows/dist/ESP32Controller.exe`

## Output Structure

```
