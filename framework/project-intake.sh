#!/bin/bash

#═══════════════════════════════════════════════════════════════════
#  WASIM'S AI WEB AGENCY - PROJECT INTAKE & SETUP SCRIPT
#═══════════════════════════════════════════════════════════════════
#
#  This script:
#  1. Asks questions about the new project
#  2. Determines which departments/branches are needed
#  3. Creates the project structure
#  4. Sets up GitHub repo with all branches
#  5. Creates initial documentation
#
#  Usage: ./project-intake.sh
#
#═══════════════════════════════════════════════════════════════════

set -e

# Colors for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Project variables
PROJECT_NAME=""
CLIENT_NAME=""
PROJECT_TYPE=""
GITHUB_VISIBILITY="private"

# Department flags (0=skip, 1=include)
declare -A DEPARTMENTS=(
    # CORE (always on)
    ["strategy"]=1
    ["design"]=1
    ["content"]=1
    ["dev"]=1
    ["security"]=1  # Always on per Wasim's requirement

    # QUALITY (default on)
    ["qa"]=1
    ["audit"]=1

    # GROWTH (based on needs)
    ["seo"]=0
    ["analytics"]=0

    # INFRASTRUCTURE
    ["devops"]=0

    # SUPPORT
    ["assets"]=1
    ["client"]=1
    ["docs"]=1
)

# Sub-branches for each department
declare -A SUB_BRANCHES=(
    ["strategy"]="planning research requirements"
    ["design"]="ui ux branding mockups"
    ["content"]="copy blog legal media"
    ["dev"]="frontend backend cms integrations responsive"
    ["security"]="audit hardening ssl auth backup"
    ["qa"]="functional browser mobile performance"
    ["audit"]="code accessibility seo performance"
    ["seo"]="technical content local analytics"
    ["analytics"]="setup goals reporting"
    ["devops"]="hosting deployment domain monitoring"
    ["assets"]="images icons fonts video"
    ["client"]="revisions communications approvals"
    ["docs"]="technical user handoff"
)

#───────────────────────────────────────────────────────────────────
# HELPER FUNCTIONS
#───────────────────────────────────────────────────────────────────

print_header() {
    echo ""
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${PURPLE}  $1${NC}"
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
}

print_section() {
    echo ""
    echo -e "${CYAN}───────────────────────────────────────────────────────────────${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${CYAN}───────────────────────────────────────────────────────────────${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

ask_yes_no() {
    local prompt="$1"
    local default="$2"
    local response

    if [ "$default" = "y" ]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi

    read -p "$prompt" response
    response=${response:-$default}

    [[ "$response" =~ ^[Yy] ]]
}

ask_choice() {
    local prompt="$1"
    shift
    local options=("$@")
    local choice

    echo "$prompt"
    for i in "${!options[@]}"; do
        echo "  $((i+1)). ${options[$i]}"
    done

    while true; do
        read -p "Enter choice (1-${#options[@]}): " choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#options[@]}" ]; then
            echo "${options[$((choice-1))]}"
            return
        fi
        echo "Invalid choice. Please try again."
    done
}

#───────────────────────────────────────────────────────────────────
# INTAKE QUESTIONS
#───────────────────────────────────────────────────────────────────

collect_basic_info() {
    print_header "🚀 NEW PROJECT INTAKE"

    read -p "Project Name (kebab-case, e.g., acme-restaurant): " PROJECT_NAME
    PROJECT_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

    read -p "Client Name: " CLIENT_NAME

    print_section "Project Type"
    PROJECT_TYPE=$(ask_choice "What type of project is this?" \
        "Landing Page" \
        "Full Website" \
        "E-commerce" \
        "Web Application" \
        "Blog/Content Site" \
        "Redesign" \
        "Maintenance/Update")

    echo ""
    print_info "Project: $PROJECT_NAME"
    print_info "Client: $CLIENT_NAME"
    print_info "Type: $PROJECT_TYPE"
}

collect_features() {
    print_section "Features & Requirements"

    echo "Which features does this project need?"
    echo ""

    if ask_yes_no "Contact Form" "y"; then
        FEATURES+=("contact-form")
    fi

    if ask_yes_no "Blog/News Section" "n"; then
        FEATURES+=("blog")
        DEPARTMENTS["content"]=1
    fi

    if ask_yes_no "E-commerce/Shop" "n"; then
        FEATURES+=("ecommerce")
        DEPARTMENTS["security"]=1
        DEPARTMENTS["devops"]=1
    fi

    if ask_yes_no "User Accounts/Login" "n"; then
        FEATURES+=("user-accounts")
        DEPARTMENTS["security"]=1
    fi

    if ask_yes_no "Booking/Reservation System" "n"; then
        FEATURES+=("booking")
        DEPARTMENTS["dev"]=1
    fi

    if ask_yes_no "Gallery/Portfolio" "n"; then
        FEATURES+=("gallery")
        DEPARTMENTS["assets"]=1
    fi

    if ask_yes_no "Multi-language Support" "n"; then
        FEATURES+=("multi-language")
    fi

    if ask_yes_no "Custom CMS/Admin Panel" "n"; then
        FEATURES+=("cms")
    fi
}

collect_special_requirements() {
    print_section "Special Requirements"

    if ask_yes_no "SEO is critical (need to rank on Google)" "y"; then
        DEPARTMENTS["seo"]=1
    fi

    if ask_yes_no "Analytics & Tracking needed" "y"; then
        DEPARTMENTS["analytics"]=1
    fi

    if ask_yes_no "Accessibility compliance (WCAG)" "n"; then
        DEPARTMENTS["audit"]=1
    fi

    if ask_yes_no "Custom hosting/server setup needed" "n"; then
        DEPARTMENTS["devops"]=1
    fi

    if ask_yes_no "High security (payments, sensitive data)" "n"; then
        DEPARTMENTS["security"]=1
    fi
}

set_project_type_defaults() {
    case "$PROJECT_TYPE" in
        "Landing Page")
            DEPARTMENTS["seo"]=1
            DEPARTMENTS["analytics"]=1
            ;;
        "Full Website")
            DEPARTMENTS["seo"]=1
            DEPARTMENTS["analytics"]=1
            DEPARTMENTS["qa"]=1
            DEPARTMENTS["audit"]=1
            ;;
        "E-commerce")
            DEPARTMENTS["seo"]=1
            DEPARTMENTS["analytics"]=1
            DEPARTMENTS["security"]=1
            DEPARTMENTS["devops"]=1
            DEPARTMENTS["qa"]=1
            DEPARTMENTS["audit"]=1
            ;;
        "Web Application")
            DEPARTMENTS["security"]=1
            DEPARTMENTS["devops"]=1
            DEPARTMENTS["qa"]=1
            DEPARTMENTS["audit"]=1
            DEPARTMENTS["analytics"]=1
            ;;
        "Blog/Content Site")
            DEPARTMENTS["seo"]=1
            DEPARTMENTS["analytics"]=1
            ;;
        "Redesign")
            DEPARTMENTS["audit"]=1
            DEPARTMENTS["qa"]=1
            ;;
        "Maintenance/Update")
            DEPARTMENTS["security"]=1
            DEPARTMENTS["audit"]=1
            ;;
    esac
}

#───────────────────────────────────────────────────────────────────
# PROJECT CREATION
#───────────────────────────────────────────────────────────────────

show_department_summary() {
    print_section "Departments to Activate"

    echo "Based on your answers, these departments will be set up:"
    echo ""

    for dept in "${!DEPARTMENTS[@]}"; do
        if [ "${DEPARTMENTS[$dept]}" -eq 1 ]; then
            print_success "$dept"
            # Show sub-branches
            for sub in ${SUB_BRANCHES[$dept]}; do
                echo "      └── $dept/$sub"
            done
        fi
    done

    echo ""
    echo "Departments NOT activated:"
    for dept in "${!DEPARTMENTS[@]}"; do
        if [ "${DEPARTMENTS[$dept]}" -eq 0 ]; then
            echo -e "  ${RED}✗ $dept${NC}"
        fi
    done
}

create_project_structure() {
    print_section "Creating Project Structure"

    # Create project directory
    PROJECT_DIR="$HOME/$PROJECT_NAME"

    if [ -d "$PROJECT_DIR" ]; then
        print_warning "Directory $PROJECT_DIR already exists!"
        if ! ask_yes_no "Continue anyway?" "n"; then
            exit 1
        fi
    else
        mkdir -p "$PROJECT_DIR"
        print_success "Created directory: $PROJECT_DIR"
    fi

    cd "$PROJECT_DIR"

    # Initialize git
    if [ ! -d ".git" ]; then
        git init
        print_success "Initialized git repository"
    fi

    # Create initial structure
    mkdir -p .claude
    mkdir -p src
    mkdir -p docs
    mkdir -p assets

    # Create README
    cat > README.md << EOF
# $PROJECT_NAME

**Client:** $CLIENT_NAME
**Type:** $PROJECT_TYPE
**Created:** $(date +%Y-%m-%d)

## Project Structure

This project uses the AI Web Agency branch-based workflow.

### Active Departments

EOF

    for dept in "${!DEPARTMENTS[@]}"; do
        if [ "${DEPARTMENTS[$dept]}" -eq 1 ]; then
            echo "- **$dept**" >> README.md
            for sub in ${SUB_BRANCHES[$dept]}; do
                echo "  - $dept/$sub" >> README.md
            done
        fi
    done

    cat >> README.md << EOF

## Workflow

1. Each department works on their dedicated branch
2. Brain (main) reviews and merges when ready
3. Use PR for code review between branches

## Quick Commands

\`\`\`bash
# Switch to a department branch
git checkout design/ui

# See all branches
git branch -a

# Merge department work to main
git checkout main
git merge design/ui
\`\`\`

---
Generated by Wasim's AI Web Agency Project Intake Script
EOF

    print_success "Created README.md"

    # Create project config
    cat > .claude/project-config.json << EOF
{
    "project_name": "$PROJECT_NAME",
    "client_name": "$CLIENT_NAME",
    "project_type": "$PROJECT_TYPE",
    "created_date": "$(date +%Y-%m-%d)",
    "features": [$(printf '"%s",' "${FEATURES[@]}" | sed 's/,$//')]
    ],
    "departments": {
EOF

    first=true
    for dept in "${!DEPARTMENTS[@]}"; do
        if [ "$first" = true ]; then
            first=false
        else
            echo "," >> .claude/project-config.json
        fi
        echo -n "        \"$dept\": ${DEPARTMENTS[$dept]}" >> .claude/project-config.json
    done

    cat >> .claude/project-config.json << EOF

    }
}
EOF

    print_success "Created .claude/project-config.json"

    # Initial commit
    git add .
    git commit -m "Initial project setup: $PROJECT_NAME

Client: $CLIENT_NAME
Type: $PROJECT_TYPE

Generated by AI Web Agency Project Intake Script"

    print_success "Created initial commit"
}

create_github_repo() {
    print_section "Setting Up GitHub Repository"

    if ! command -v gh &> /dev/null; then
        print_warning "GitHub CLI (gh) not installed. Skipping GitHub setup."
        print_info "You can manually create the repo and run: git remote add origin <url>"
        return
    fi

    if ask_yes_no "Create GitHub repository?" "y"; then
        if ask_yes_no "Make repository private?" "y"; then
            GITHUB_VISIBILITY="private"
        else
            GITHUB_VISIBILITY="public"
        fi

        gh repo create "$PROJECT_NAME" --"$GITHUB_VISIBILITY" --source=. --push
        print_success "Created GitHub repository: $PROJECT_NAME ($GITHUB_VISIBILITY)"
    fi
}

create_department_branches() {
    print_section "Creating Department Branches"

    for dept in "${!DEPARTMENTS[@]}"; do
        if [ "${DEPARTMENTS[$dept]}" -eq 1 ]; then
            for sub in ${SUB_BRANCHES[$dept]}; do
                branch_name="$dept/$sub"
                git checkout -b "$branch_name" 2>/dev/null || git checkout "$branch_name"

                # Create department README
                mkdir -p "$dept"
                cat > "$dept/README-$sub.md" << EOF
# $dept / $sub

This branch is for **$sub** work within the **$dept** department.

## Responsibilities

- [ ] Define specific tasks here

## How to Use

1. Make your changes in this branch
2. Commit with clear messages
3. Push to origin
4. Create PR when ready for review

## Related Branches

EOF
                for related_sub in ${SUB_BRANCHES[$dept]}; do
                    if [ "$related_sub" != "$sub" ]; then
                        echo "- $dept/$related_sub" >> "$dept/README-$sub.md"
                    fi
                done

                git add .
                git commit -m "Setup $branch_name branch" 2>/dev/null || true

                print_success "Created branch: $branch_name"
            done
        fi
    done

    # Return to main
    git checkout main

    # Push all branches
    if git remote get-url origin &>/dev/null; then
        print_info "Pushing all branches to GitHub..."
        git push --all -u origin
        print_success "All branches pushed to GitHub"
    fi
}

show_final_summary() {
    print_header "🎉 PROJECT SETUP COMPLETE!"

    echo -e "${GREEN}Project:${NC} $PROJECT_NAME"
    echo -e "${GREEN}Location:${NC} $PROJECT_DIR"
    echo -e "${GREEN}Client:${NC} $CLIENT_NAME"
    echo -e "${GREEN}Type:${NC} $PROJECT_TYPE"
    echo ""

    echo "Branches created:"
    git branch -a | grep -v "remotes" | sed 's/^/  /'

    echo ""
    echo -e "${CYAN}Next Steps:${NC}"
    echo "  1. cd $PROJECT_DIR"
    echo "  2. Start working: git checkout design/ui"
    echo "  3. Open in Claude Code Browser to work from phone"
    echo ""

    if git remote get-url origin &>/dev/null; then
        echo -e "${BLUE}GitHub URL:${NC} $(git remote get-url origin)"
    fi

    print_header "Happy Building! 🚀"
}

#───────────────────────────────────────────────────────────────────
# MAIN EXECUTION
#───────────────────────────────────────────────────────────────────

main() {
    clear
    print_header "🏢 WASIM'S AI WEB AGENCY"
    echo "        Project Intake & Setup Script"
    echo "        Version 1.0"
    echo ""

    # Collect information
    collect_basic_info
    set_project_type_defaults
    collect_features
    collect_special_requirements

    # Show summary
    show_department_summary

    echo ""
    if ! ask_yes_no "Proceed with project creation?" "y"; then
        echo "Aborted."
        exit 0
    fi

    # Create everything
    create_project_structure
    create_github_repo
    create_department_branches

    # Final summary
    show_final_summary
}

# Run main
main "$@"
