#!/bin/bash

# Script to recursively delete all bin and obj folders
# Usage: ./clean-bin-obj.sh

# Get the root directory (parent of scripts folder)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

echo "Cleaning bin and obj folders from: $ROOT_DIR"
echo "================================================"

# Find and delete all bin folders
echo "Deleting bin folders..."
find "$ROOT_DIR" -type d -name "bin" -exec rm -rf {} + 2>/dev/null || true

# Find and delete all obj folders
echo "Deleting obj folders..."
find "$ROOT_DIR" -type d -name "obj" -exec rm -rf {} + 2>/dev/null || true

echo "================================================"
echo "Cleanup complete!"
