#!/bin/bash

set -e

echo "Detecting operating system..."

OS="$(uname -s)"

case "$OS" in
  Linux*)
    echo "Installing OPA on Linux..."
    wget https://openpolicyagent.org/downloads/latest/opa_linux_amd64 -O opa
    chmod +x opa
    sudo mv opa /usr/local/bin/opa
    echo "OPA installed successfully on Linux."
    ;;
  Darwin*)
    echo "Detected macOS. Installing OPA via Homebrew..."
    brew install opa
    ;;
  CYGWIN*|MINGW32*|MSYS*|MINGW*)
    echo "Detected Windows. Please run the following command in PowerShell:"
    echo 'Invoke-WebRequest -Uri "https://openpolicyagent.org/downloads/latest/opa_windows_amd64.exe" -OutFile "opa.exe"'
    ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac