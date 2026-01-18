#!/bin/bash

# Script to generate a new entity with its mapper and DTO
# Following conventions from UserManagement module

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Base paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MODULES_DIR="$PROJECT_ROOT/Boxty/ServerApp/Modules"
SHARED_DTO_DIR="$PROJECT_ROOT/Boxty/SharedApp/DTOs"

# Function to display colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to convert PascalCase to camelCase
to_camel_case() {
    local str="$1"
    echo "${str:0:1}" | tr '[:upper:]' '[:lower:]' && echo "${str:1}"
}

# Function to list available modules
list_modules() {
    print_info "Available modules:" >&2
    local index=1
    for module in "$MODULES_DIR"/*; do
        if [ -d "$module" ] && [ "$(basename "$module")" != "Shared" ]; then
            echo "  $index) $(basename "$module")" >&2
            ((index++))
        fi
    done
}

# Function to get module choice
get_module() {
    list_modules
    echo "" >&2
    read -p "Enter the module name (or number): " module_input >&2
    
    # Check if input is a number
    if [[ "$module_input" =~ ^[0-9]+$ ]]; then
        local index=1
        for module in "$MODULES_DIR"/*; do
            if [ -d "$module" ] && [ "$(basename "$module")" != "Shared" ]; then
                if [ "$index" -eq "$module_input" ]; then
                    echo "$(basename "$module")"
                    return 0
                fi
                ((index++))
            fi
        done
        print_error "Invalid module number" >&2
        exit 1
    else
        # Check if module exists
        if [ -d "$MODULES_DIR/$module_input" ]; then
            echo "$module_input"
            return 0
        else
            print_error "Module '$module_input' does not exist" >&2
            exit 1
        fi
    fi
}

# Function to get entity name
get_entity_name() {
    read -p "Enter the name of the new entity (PascalCase): " entity_name >&2
    
    # Validate entity name (should start with capital letter)
    if [[ ! "$entity_name" =~ ^[A-Z][a-zA-Z0-9]*$ ]]; then
        print_error "Entity name must be in PascalCase (e.g., MyEntity)" >&2
        exit 1
    fi
    
    echo "$entity_name"
}

# Function to generate entity file
generate_entity() {
    local module="$1"
    local entity_name="$2"
    local entity_path="$MODULES_DIR/$module/Entities/${entity_name}.cs"
    
    if [ -f "$entity_path" ]; then
        print_error "Entity '$entity_name' already exists in module '$module'" >&2
        exit 1
    fi
    
    print_info "Creating entity: $entity_path"
    
    cat > "$entity_path" << EOF
using Boxty.ServerBase.Entities;
using Boxty.SharedBase.Interfaces;

namespace Boxty.ServerApp.Modules.${module}.Entities
{
    public class ${entity_name} : BaseEntity<${entity_name}>, IEntity
    {
        // TODO: Add your entity properties here
        // Example:
        // public required string Name { get; set; }
        // public string Description { get; set; } = string.Empty;
        // public Guid TenantId { get; set; }
    }
}
EOF
    
    print_success "Entity created at: $entity_path"
}

# Function to generate mapper file
generate_mapper() {
    local module="$1"
    local entity_name="$2"
    local mapper_path="$MODULES_DIR/$module/Infrastructure/Mappers/${entity_name}Mapper.cs"
    
    # Create Mappers directory if it doesn't exist
    mkdir -p "$MODULES_DIR/$module/Infrastructure/Mappers"
    
    if [ -f "$mapper_path" ]; then
        print_warning "Mapper for '$entity_name' already exists, skipping..."
        return 0
    fi
    
    print_info "Creating mapper: $mapper_path"
    
    cat > "$mapper_path" << EOF
using Boxty.ServerBase.Mappers;
using Boxty.ServerApp.Modules.${module}.Entities;
using Boxty.SharedApp.DTOs.${module};
using System.Security.Claims;

namespace Boxty.ServerApp.Modules.${module}.Infrastructure.Mappers
{
    public class ${entity_name}Mapper : IMapper<${entity_name}, ${entity_name}Dto>
    {
        public ${entity_name}Dto Map(${entity_name} entity, ClaimsPrincipal? user = null)
        {
            return new ${entity_name}Dto
            {
                Id = entity.Id,
                // TODO: Map entity properties to DTO
                CreatedDate = entity.CreatedDate,
                CreatedBy = entity.CreatedBy,
                ModifiedDate = entity.ModifiedDate,
                LastModifiedBy = entity.LastModifiedBy
            };
        }

        public ${entity_name} Map(${entity_name}Dto dto, ClaimsPrincipal? user = null)
        {
            return new ${entity_name}
            {
                Id = dto.Id,
                // TODO: Map DTO properties to entity
                CreatedDate = dto.CreatedDate,
                CreatedBy = dto.CreatedBy,
                ModifiedDate = dto.ModifiedDate,
                LastModifiedBy = dto.LastModifiedBy
            };
        }

        public IEnumerable<${entity_name}Dto> Map(IEnumerable<${entity_name}> entities, ClaimsPrincipal? user = null)
        {
            return entities.Select(entity => Map(entity, user));
        }

        public IEnumerable<${entity_name}> Map(IEnumerable<${entity_name}Dto> dtos, ClaimsPrincipal? user = null)
        {
            return dtos.Select(dto => Map(dto, user));
        }

        public void Map(${entity_name}Dto dto, ${entity_name} entity, ClaimsPrincipal? user = null)
        {
            entity.Id = dto.Id;
            // TODO: Map DTO properties to entity
            entity.CreatedDate = dto.CreatedDate;
            entity.CreatedBy = dto.CreatedBy;
            entity.ModifiedDate = dto.ModifiedDate;
            entity.LastModifiedBy = dto.LastModifiedBy;
        }

        public void Map(${entity_name} entity, ${entity_name}Dto dto, ClaimsPrincipal? user = null)
        {
            dto.Id = entity.Id;
            // TODO: Map entity properties to DTO
            dto.CreatedDate = entity.CreatedDate;
            dto.CreatedBy = entity.CreatedBy;
            dto.ModifiedDate = entity.ModifiedDate;
            dto.LastModifiedBy = entity.LastModifiedBy;
        }
    }
}
EOF
    
    print_success "Mapper created at: $mapper_path"
}

# Function to generate DTO file
generate_dto() {
    local module="$1"
    local entity_name="$2"
    local dto_dir="$SHARED_DTO_DIR/$module"
    local dto_path="$dto_dir/${entity_name}Dto.cs"
    
    # Create DTO directory for module if it doesn't exist
    if [ ! -d "$dto_dir" ]; then
        print_info "Creating DTO directory: $dto_dir"
        mkdir -p "$dto_dir"
    fi
    
    if [ -f "$dto_path" ]; then
        print_warning "DTO for '$entity_name' already exists, skipping..."
        return 0
    fi
    
    print_info "Creating DTO: $dto_path"
    
    cat > "$dto_path" << EOF
using Boxty.SharedBase.DTOs;
using Boxty.SharedBase.Interfaces;
using Boxty.SharedApp.DTOs;

namespace Boxty.SharedApp.DTOs.${module}
{
    public class ${entity_name}Dto : BaseDto<${entity_name}Dto>, IDto, IAuditDto, IAutoCrud
    {
        // TODO: Add your DTO properties here
        // Example:
        // public string Name { get; set; } = string.Empty;
        // public string Description { get; set; } = string.Empty;
        // public Guid TenantId { get; set; }
        
        public string DisplayName => "TODO: Set display name"; // TODO: Update this
    }
}
EOF
    
    print_success "DTO created at: $dto_path"
}

# Function to pluralize entity name (simple implementation)
pluralize() {
    local name="$1"
    # Simple pluralization rules
    if [[ "$name" =~ y$ ]]; then
        echo "${name%y}ies"
    elif [[ "$name" =~ (s|x|z|ch|sh)$ ]]; then
        echo "${name}es"
    else
        echo "${name}s"
    fi
}

# Function to update DbContext
update_dbcontext() {
    local module="$1"
    local entity_name="$2"
    local dbcontext_path="$MODULES_DIR/$module/Infrastructure/Database/${module}DbContext.cs"
    
    if [ ! -f "$dbcontext_path" ]; then
        print_warning "DbContext not found at: $dbcontext_path"
        print_warning "Skipping DbContext update. You'll need to add the DbSet manually."
        return 0
    fi
    
    print_info "Updating DbContext: $dbcontext_path"
    
    local plural_name=$(pluralize "$entity_name")
    
    # Check if DbSet already exists
    if grep -q "DbSet<$entity_name>" "$dbcontext_path"; then
        print_warning "DbSet<$entity_name> already exists in DbContext, skipping..."
        return 0
    fi
    
    # Create a temporary file
    local temp_file="${dbcontext_path}.tmp"
    
    # Read the file and add DbSet and configuration
    local added_dbset=false
    local added_config=false
    local in_model_creating=false
    local brace_count=0
    
    while IFS= read -r line; do
        # Add DbSet before protected override void OnModelCreating
        if [[ "$line" =~ "protected override void OnModelCreating" ]] && [ "$added_dbset" = false ]; then
            echo "        public DbSet<$entity_name> $plural_name { get; set; }" >> "$temp_file"
            echo "" >> "$temp_file"
            added_dbset=true
        fi
        
        # Detect when we're in OnModelCreating
        if [[ "$line" =~ "protected override void OnModelCreating" ]]; then
            in_model_creating=true
            echo "$line" >> "$temp_file"
            continue
        fi
        
        # Track braces when in OnModelCreating to find the method's closing brace
        if [ "$in_model_creating" = true ]; then
            # Check if this line is the closing brace before updating the line
            # We need to check BEFORE counting to insert before the closing brace
            if [[ "$line" =~ ^[[:space:]]*\}[[:space:]]*$ ]] && [ $brace_count -eq 1 ] && [ "$added_config" = false ]; then
                # Add entity configuration before the closing brace
                echo "" >> "$temp_file"
                echo "            modelBuilder.Entity<$entity_name>()" >> "$temp_file"
                echo "                .Property(p => p.Id)" >> "$temp_file"
                echo "                .HasDefaultValueSql(\"gen_random_uuid()\");" >> "$temp_file"
                added_config=true
                in_model_creating=false
            fi
            
            # Count opening and closing braces
            local open_braces=$(echo "$line" | grep -o '{' | wc -l)
            local close_braces=$(echo "$line" | grep -o '}' | wc -l)
            brace_count=$((brace_count + open_braces - close_braces))
        fi
        
        echo "$line" >> "$temp_file"
    done < "$dbcontext_path"
    
    # Replace original file with updated one
    mv "$temp_file" "$dbcontext_path"
    
    print_success "DbContext updated with DbSet<$entity_name> $plural_name and entity configuration"
}

# Main script execution
print_info "Entity Generator Script" >&2
echo "================================" >&2
echo "" >&2

# Get module name
MODULE=$(get_module)
print_success "Selected module: $MODULE" >&2
echo "" >&2

# Get entity name
ENTITY_NAME=$(get_entity_name)
print_success "Entity name: $ENTITY_NAME" >&2
echo "" >&2

# Confirm before proceeding
print_warning "This will create the following files:" >&2
echo "  1. Entity:  $MODULES_DIR/$MODULE/Entities/${ENTITY_NAME}.cs" >&2
echo "  2. Mapper:  $MODULES_DIR/$MODULE/Infrastructure/Mappers/${ENTITY_NAME}Mapper.cs" >&2
echo "  3. DTO:     $SHARED_DTO_DIR/$MODULE/${ENTITY_NAME}Dto.cs" >&2
echo "" >&2
print_warning "And will update:" >&2
echo "  4. DbContext: $MODULES_DIR/$MODULE/Infrastructure/Database/${MODULE}DbContext.cs" >&2
echo "     - Add DbSet<${ENTITY_NAME}> property" >&2
echo "     - Add entity configuration with UUID generation" >&2
echo "" >&2
read -p "Continue? (y/n): " confirm >&2

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    print_info "Cancelled by user" >&2
    exit 0
fi

echo "" >&2

# Generate files
generate_entity "$MODULE" "$ENTITY_NAME"
generate_mapper "$MODULE" "$ENTITY_NAME"
generate_dto "$MODULE" "$ENTITY_NAME"
update_dbcontext "$MODULE" "$ENTITY_NAME"

echo ""
print_success "================================"
print_success "Entity generation complete!"
print_success "================================"
echo ""
print_info "Next steps:"
echo "  1. Add properties to the entity in: Modules/$MODULE/Entities/${ENTITY_NAME}.cs"
echo "  2. Update the mapper with property mappings in: Modules/$MODULE/Infrastructure/Mappers/${ENTITY_NAME}Mapper.cs"
echo "  3. Add corresponding properties to the DTO in: SharedApp/DTOs/$MODULE/${ENTITY_NAME}Dto.cs"
echo "  4. Update the DisplayName property in the DTO"
echo "  5. Review the DbContext updates in: Modules/$MODULE/Infrastructure/Database/${MODULE}DbContext.cs"
echo ""
