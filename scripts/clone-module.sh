#!/bin/bash

# Script to clone a module and prepare it as a starter template
set -e

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Get the project root (parent of scripts directory)
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

# Base path
BASE_PATH="$PROJECT_ROOT/Boxty/ServerApp/Modules"

echo -e "${GREEN}=== Module Cloning Script ===${NC}"
echo ""

# Prompt for new module name
read -p "Enter the new module name (e.g., MyNewModule): " NEW_MODULE_NAME

if [ -z "$NEW_MODULE_NAME" ]; then
    echo -e "${RED}Error: Module name cannot be empty${NC}"
    exit 1
fi

# Check if module already exists
if [ -d "$BASE_PATH/$NEW_MODULE_NAME" ]; then
    echo -e "${RED}Error: Module '$NEW_MODULE_NAME' already exists${NC}"
    exit 1
fi

# Show available modules to clone (exclude Auth)
echo ""
echo "Available modules to clone:"
echo "1) UserManagement"
echo "2) Shared"
echo ""
read -p "Select module to clone (1 or 2): " MODULE_CHOICE

case $MODULE_CHOICE in
    1)
        SOURCE_MODULE="UserManagement"
        ;;
    2)
        SOURCE_MODULE="Shared"
        ;;
    *)
        echo -e "${RED}Error: Invalid choice${NC}"
        exit 1
        ;;
esac

SOURCE_PATH="$BASE_PATH/$SOURCE_MODULE"
DEST_PATH="$BASE_PATH/$NEW_MODULE_NAME"

echo ""
echo -e "${YELLOW}Cloning '$SOURCE_MODULE' to '$NEW_MODULE_NAME'...${NC}"

# Step 1: Clone the module directory
cp -r "$SOURCE_PATH" "$DEST_PATH"
echo -e "${GREEN}✓ Module directory cloned${NC}"

# Step 2: Remove all .cs files from Entities folder
if [ -d "$DEST_PATH/Entities" ]; then
    echo -e "${YELLOW}Removing .cs files from Entities folder...${NC}"
    find "$DEST_PATH/Entities" -name "*.cs" -type f -delete
    echo -e "${GREEN}✓ Entity files removed${NC}"
fi

# Step 3: Remove Migrations folder
if [ -d "$DEST_PATH/Infrastructure/Database/Migrations" ]; then
    echo -e "${YELLOW}Removing Migrations folder...${NC}"
    rm -rf "$DEST_PATH/Infrastructure/Database/Migrations"
    echo -e "${GREEN}✓ Migrations removed${NC}"
fi

# Step 4: Remove AuthorizationHandlers folder
if [ -d "$DEST_PATH/Infrastructure/AuthorizationHandlers" ]; then
    echo -e "${YELLOW}Removing AuthorizationHandlers folder...${NC}"
    rm -rf "$DEST_PATH/Infrastructure/AuthorizationHandlers"
    echo -e "${GREEN}✓ AuthorizationHandlers removed${NC}"
fi

# Step 5: Remove bin and obj folders
echo -e "${YELLOW}Removing bin and obj folders...${NC}"
find "$DEST_PATH" -type d -name "bin" -exec rm -rf {} + 2>/dev/null || true
find "$DEST_PATH" -type d -name "obj" -exec rm -rf {} + 2>/dev/null || true
echo -e "${GREEN}✓ Build artifacts removed${NC}"

# Step 6: Rename .csproj files
echo -e "${YELLOW}Renaming .csproj files...${NC}"
find "$DEST_PATH" -name "*.csproj" | while read -r file; do
    newfile=$(echo "$file" | sed "s/$SOURCE_MODULE/$NEW_MODULE_NAME/g")
    if [ "$file" != "$newfile" ]; then
        mv "$file" "$newfile"
        echo "  Renamed: $(basename $file) -> $(basename $newfile)"
    fi
done
echo -e "${GREEN}✓ .csproj files renamed${NC}"

# Step 7: Update file contents - replace all occurrences of source module name with new module name
echo -e "${YELLOW}Updating file contents...${NC}"

# Find all files (excluding binary files, bin, obj directories)
find "$DEST_PATH" -type f \( -name "*.cs" -o -name "*.csproj" -o -name "*.json" -o -name "*.razor" -o -name "*.config" \) | while read -r file; do
    # Use sed to replace module name (case sensitive)
    sed -i "s/$SOURCE_MODULE/$NEW_MODULE_NAME/g" "$file"
done
echo -e "${GREEN}✓ File contents updated${NC}"

# Step 8: Clean up DbContext file
# First, find and rename the old DbContext file
OLD_DBCONTEXT_FILE=$(find "$DEST_PATH/Infrastructure/Database" -name "*DbContext.cs" -type f | grep -v "DesignTime" | head -1)
DBCONTEXT_FILE="$DEST_PATH/Infrastructure/Database/${NEW_MODULE_NAME}DbContext.cs"

if [ -n "$OLD_DBCONTEXT_FILE" ] && [ "$OLD_DBCONTEXT_FILE" != "$DBCONTEXT_FILE" ]; then
    echo -e "${YELLOW}Renaming DbContext file...${NC}"
    mv "$OLD_DBCONTEXT_FILE" "$DBCONTEXT_FILE"
fi

if [ -f "$DBCONTEXT_FILE" ]; then
    echo -e "${YELLOW}Cleaning up DbContext...${NC}"
    
    # Create a minimal DbContext
    cat > "$DBCONTEXT_FILE" << EOF
using Boxty.ServerBase.Database;
using Boxty.ServerBase.Entities;
using Microsoft.EntityFrameworkCore;
using Boxty.ServerApp.Modules.${NEW_MODULE_NAME}.Entities;
using Boxty.SharedApp.Enums;

namespace Boxty.ServerApp.Modules.${NEW_MODULE_NAME}.Infrastructure.Database
{
    public sealed class ${NEW_MODULE_NAME}DbContext(DbContextOptions<${NEW_MODULE_NAME}DbContext> options) : BaseDbContext<${NEW_MODULE_NAME}DbContext>(options), IDbContext<${NEW_MODULE_NAME}DbContext>
    {
        // Add your DbSet properties here
        // Example: public DbSet<YourEntity> YourEntities { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasDefaultSchema(Schema.${NEW_MODULE_NAME});
            modelBuilder.ApplyConfigurationsFromAssembly(typeof(${NEW_MODULE_NAME}DbContext).Assembly);

            // Add your entity configurations here
            // Example:
            // modelBuilder.Entity<YourEntity>()
            //     .Property(p => p.Id)
            //     .HasDefaultValueSql("gen_random_uuid()");
        }
    }
}
EOF
    echo -e "${GREEN}✓ DbContext cleaned up${NC}"
fi

# Step 9: Clean up Module file
# First, find and rename the old Module file
OLD_MODULE_FILE=$(find "$DEST_PATH/Infrastructure" -maxdepth 1 -name "*Module.cs" -type f | head -1)
MODULE_FILE="$DEST_PATH/Infrastructure/${NEW_MODULE_NAME}Module.cs"

if [ -n "$OLD_MODULE_FILE" ] && [ "$OLD_MODULE_FILE" != "$MODULE_FILE" ]; then
    echo -e "${YELLOW}Renaming Module file...${NC}"
    mv "$OLD_MODULE_FILE" "$MODULE_FILE"
fi

if [ -f "$MODULE_FILE" ]; then
    echo -e "${YELLOW}Cleaning up Module service registrations...${NC}"
    
    # Create a minimal Module file
    cat > "$MODULE_FILE" << EOF
using Boxty.ServerBase.Auth.Providers;
using Boxty.ServerBase.Database;
using Boxty.ServerBase.Modules;
using Boxty.ServerBase.Queries;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Boxty.ServerApp.Modules.${NEW_MODULE_NAME}.Entities;
using Boxty.ServerApp.Modules.${NEW_MODULE_NAME}.Infrastructure.Database;
using Boxty.ServerApp.Modules.Shared.Contracts;

namespace Boxty.ServerApp.Modules.${NEW_MODULE_NAME}.Infrastructure
{
    public class ${NEW_MODULE_NAME}Module : IModule
    {
        public IServiceCollection RegisterModuleServices(IServiceCollection services, IConfiguration configuration)
        {
            var connectionString = configuration.GetConnectionString("DefaultConnection") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
            services.AddDbContext<IDbContext<${NEW_MODULE_NAME}DbContext>, ${NEW_MODULE_NAME}DbContext>(options =>
                            options.UseNpgsql(configuration.GetConnectionString("DefaultConnection")));

            // Add your service registrations here
            // Example: services.AddScoped<IYourQuery, YourQuery>();
            // Example: services.AddScoped<IAuthorizationHandler, YourAuthorizationHandler>();

            return services;
        }
        
        public WebApplication ConfigureModuleServices(WebApplication app, bool isDevelopment)
        {
            using (var scope = app.Services.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<${NEW_MODULE_NAME}DbContext>();
                dbContext.Database.Migrate();
            }
            return app;
        }
    }
}
EOF
    echo -e "${GREEN}✓ Module file cleaned up${NC}"
fi

# Step 10: Update Schema enum if it exists
SCHEMA_FILE="$DEST_PATH/Infrastructure/Database/Schema.cs"
if [ -f "$SCHEMA_FILE" ]; then
    echo -e "${YELLOW}Updating Schema file...${NC}"
    cat > "$SCHEMA_FILE" << EOF
namespace Boxty.SharedApp.Enums
{
    public static class Schema
    {
        public const string ${NEW_MODULE_NAME} = "${NEW_MODULE_NAME}";
    }
}
EOF
    echo -e "${GREEN}✓ Schema file updated${NC}"
fi

# Step 11: Clean up Queries folder if it exists
if [ -d "$DEST_PATH/Infrastructure/Queries" ]; then
    echo -e "${YELLOW}Removing query files...${NC}"
    find "$DEST_PATH/Infrastructure/Queries" -name "*.cs" -type f -delete
    echo -e "${GREEN}✓ Query files removed${NC}"
fi

# Step 12: Clean up Mappers folder if it exists
if [ -d "$DEST_PATH/Infrastructure/Mappers" ]; then
    echo -e "${YELLOW}Removing mapper files...${NC}"
    find "$DEST_PATH/Infrastructure/Mappers" -name "*.cs" -type f -delete
    echo -e "${GREEN}✓ Mapper files removed${NC}"
fi

# Step 13: Clean up Application Commands if they exist
if [ -d "$DEST_PATH/Application" ]; then
    echo -e "${YELLOW}Removing application command files...${NC}"
    find "$DEST_PATH/Application" -name "*.cs" -type f -delete
    echo -e "${GREEN}✓ Application command files removed${NC}"
fi

# Step 14: Clean up Endpoints if they exist
if [ -d "$DEST_PATH/Endpoints" ]; then
    echo -e "${YELLOW}Removing endpoint files...${NC}"
    find "$DEST_PATH/Endpoints" -name "*.cs" -type f -delete
    echo -e "${GREEN}✓ Endpoint files removed${NC}"
fi

# Step 15: Clean up Services if they exist
if [ -d "$DEST_PATH/Services" ]; then
    echo -e "${YELLOW}Removing service files...${NC}"
    find "$DEST_PATH/Services" -name "*.cs" -type f -delete
    echo -e "${GREEN}✓ Service files removed${NC}"
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║            Module cloning completed successfully!              ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}New module created at: $DEST_PATH${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Add your entity classes to: $DEST_PATH/Entities/"
echo "2. Update DbContext with your entities: $DBCONTEXT_FILE"
echo "3. Add your queries, commands, and services"
echo "4. Register services in: $MODULE_FILE"
echo "5. Create initial migration: dotnet ef migrations add InitialCreate --project $DEST_PATH/Infrastructure"
echo "6. Add module to your application's startup/program configuration"
echo ""
