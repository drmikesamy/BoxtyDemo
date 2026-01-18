#!/bin/bash

# Script to quickly change logging levels for debugging

set -e

APPSETTINGS_FILE="./Server/WebApi/appsettings.Development.json"

show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --verbose, -v      Enable verbose logging (includes EF Core SQL queries)"
    echo "  --normal, -n       Set normal logging levels (default)"
    echo "  --minimal, -m      Minimal logging (warnings and errors only)"
    echo "  --database, -d     Enable database debugging (slow queries, connections)"
    echo "  --help, -h         Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 -v              # Enable verbose logging for debugging"
    echo "  $0 -n              # Reset to normal logging"
    echo "  $0 -d              # Enable database debugging"
}

enable_verbose_logging() {
    echo "Enabling verbose logging..."
    
    # Backup current settings
    cp "$APPSETTINGS_FILE" "$APPSETTINGS_FILE.backup"
    
    # Use jq to update logging levels
    jq '.Logging.LogLevel."Microsoft.EntityFrameworkCore" = "Information" |
        .Logging.LogLevel."Microsoft.EntityFrameworkCore.Database.Command" = "Information" |
        .Logging.LogLevel."Microsoft.EntityFrameworkCore.Database.Connection" = "Information" |
        .Development.EnableDatabaseQueryLogging = true |
        .DatabaseDebugging.LogConnectionEvents = true |
        .DatabaseDebugging.LogParameterValues = true' "$APPSETTINGS_FILE" > temp.json && mv temp.json "$APPSETTINGS_FILE"
    
    echo "Verbose logging enabled. SQL queries and connections will now be logged."
    echo "Remember to run './logging-config.sh -n' to reset to normal levels."
}

enable_normal_logging() {
    echo "Setting normal logging levels..."
    
    jq '.Logging.LogLevel."Microsoft.EntityFrameworkCore" = "Warning" |
        .Logging.LogLevel."Microsoft.EntityFrameworkCore.Database.Command" = "None" |
        .Logging.LogLevel."Microsoft.EntityFrameworkCore.Database.Connection" = "None" |
        .Development.EnableDatabaseQueryLogging = false |
        .DatabaseDebugging.LogConnectionEvents = false |
        .DatabaseDebugging.LogParameterValues = false' "$APPSETTINGS_FILE" > temp.json && mv temp.json "$APPSETTINGS_FILE"
    
    echo "Normal logging levels restored."
}

enable_minimal_logging() {
    echo "Setting minimal logging..."
    
    jq '.Logging.LogLevel.Default = "Warning" |
        .Logging.LogLevel."Microsoft.AspNetCore" = "Error" |
        .Logging.LogLevel."Microsoft.EntityFrameworkCore" = "Error"' "$APPSETTINGS_FILE" > temp.json && mv temp.json "$APPSETTINGS_FILE"
    
    echo "Minimal logging enabled. Only warnings and errors will be shown."
}

enable_database_debugging() {
    echo "Enabling database debugging..."
    
    jq '.DatabaseDebugging.LogSlowQueries = true |
        .DatabaseDebugging.LogConnectionEvents = true |
        .Development.EnableDatabaseQueryLogging = true' "$APPSETTINGS_FILE" > temp.json && mv temp.json "$APPSETTINGS_FILE"
    
    echo "Database debugging enabled. Slow queries and connection events will be logged."
}

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed. Please install jq first."
    echo "Ubuntu/Debian: sudo apt-get install jq"
    echo "macOS: brew install jq"
    exit 1
fi

# Check if appsettings file exists
if [ ! -f "$APPSETTINGS_FILE" ]; then
    echo "Error: $APPSETTINGS_FILE not found. Make sure you're running this from the project root."
    exit 1
fi

# Parse command line arguments
case "${1:-}" in
    --verbose|-v)
        enable_verbose_logging
        ;;
    --normal|-n)
        enable_normal_logging
        ;;
    --minimal|-m)
        enable_minimal_logging
        ;;
    --database|-d)
        enable_database_debugging
        ;;
    --help|-h|"")
        show_help
        ;;
    *)
        echo "Error: Unknown option '$1'"
        echo ""
        show_help
        exit 1
        ;;
esac
