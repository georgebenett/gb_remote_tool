#!/usr/bin/env python3
"""
Create a simple icon for the ESP32 Controller application
"""

from PyQt6.QtGui import QPainter, QPen, QBrush, QColor
from PyQt6.QtCore import QSize
from PyQt6.QtWidgets import QApplication
import sys

def create_icon():
    """Create a simple icon with ESP32 and controller theme"""
    app = QApplication(sys.argv)
    
    # Create a 64x64 pixmap
    from PyQt6.QtGui import QPixmap
    pixmap = QPixmap(64, 64)
    pixmap.fill(QColor(0, 0, 0, 0))  # Transparent background
    
    painter = QPainter(pixmap)
    painter.setRenderHint(QPainter.RenderHint.Antialiasing)
    
    # Draw ESP32 board outline
    painter.setPen(QPen(QColor(0, 100, 200), 2))
    painter.setBrush(QBrush(QColor(50, 150, 255, 200)))
    painter.drawRoundedRect(8, 8, 48, 32, 4, 4)
    
    # Draw controller elements
    painter.setPen(QPen(QColor(255, 100, 0), 2))
    painter.setBrush(QBrush(QColor(255, 150, 50, 200)))
    
    # Throttle control
    painter.drawEllipse(20, 45, 12, 12)
    
    # Connection lines
    painter.setPen(QPen(QColor(100, 100, 100), 1))
    painter.drawLine(32, 40, 26, 45)
    
    # Save as ICO file
    pixmap.save("icon.ico", "ICO")
    print("Icon created: icon.ico")
    
    painter.end()
    app.quit()

if __name__ == "__main__":
    create_icon()
