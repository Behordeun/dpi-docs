#!/bin/bash

set -e

echo "Detecting operating system..."

OS="$(uname -s)"

case "$OS" in
  Linux*)
    echo "Installing Temporal CLI on Linux..."
    curl -sSL https://temporal.download/cli.sh | bash
    echo "Starting Temporal dev server..."
    temporal server start-dev
    ;;
  Darwin*)
    echo "Detected macOS. Installing Temporal via Homebrew..."
    brew install temporal
    echo "Starting Temporal dev server..."
    temporal server start-dev
    ;;
  CYGWIN*|MINGW32*|MSYS*|MINGW*)
    echo "Detected Windows. Please run the following PowerShell commands manually:"
    echo ''
    echo 'Invoke-WebRequest -Uri "https://temporal.download/cli-windows.zip" -OutFile "temporal.zip"'
    echo 'Expand-Archive -Path temporal.zip -DestinationPath .'
    echo '.\\temporal.exe server start-dev'
    ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac
