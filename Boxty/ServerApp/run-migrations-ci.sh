#!/bin/bash

# Non-interactive migration script for CI/CD
cd "$(dirname "$0")"

ASPNETCORE_ENVIRONMENT=${ASPNETCORE_ENVIRONMENT:-Production}

echo "Running database migrations in $ASPNETCORE_ENVIRONMENT environment..."

# Debug connection string (without exposing sensitive data)
if [ -n "$ConnectionStrings__DefaultConnection" ]; then
    echo "✅ Connection string is set (length: ${#ConnectionStrings__DefaultConnection})"
else
    echo "❌ Connection string is not set!"
    echo "Available environment variables:"
    env | grep -E "(CONNECTION|Database|POSTGRES)" | head -5
    exit 1
fi

run_module_migration() {
    local module_name=$1
    local context_name="${module_name}DbContext"
    local project_path="$(pwd)/Modules/${module_name}/Infrastructure/ServerApp.Modules.${module_name}.Infrastructure.csproj"
    
    echo "Running migration for $module_name..."
    
    dotnet ef database update \
        --context "$context_name" \
        --project "$project_path" \
        --startup-project "$(pwd)/WebApi/WebApi.csproj" \
        --connection "$ConnectionStrings__DefaultConnection" \
        --verbose
    
    if [ $? -eq 0 ]; then
        echo "✅ $module_name migration completed successfully"
    else
        echo "❌ $module_name migration failed"
        exit 1
    fi
}

# Discover and migrate all modules (including Auth)
for module_dir in Modules/*/Infrastructure; do
    if [ -d "$module_dir" ]; then
        module_name=$(basename "$(dirname "$module_dir")")
        run_module_migration "$module_name"
    fi
done

echo "🎉 All database migrations completed successfully!"