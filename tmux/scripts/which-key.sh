#!/usr/bin/env bash
# tmux-which-key: A lightweight which-key implementation for tmux
# Inspired by which-key.nvim and emacs which-key
# Usage: which-key.sh [section]

CONFIG="${TMUX_WHICH_KEY_CONFIG:-$HOME/.config/tmux/which-key.conf}"
SECTION="${1:-root}"
SCRIPT_PATH="$HOME/.config/tmux/scripts/which-key.sh"

# Catppuccin Mocha defaults
TITLE_STYLE="align=centre,bold,fg=#89b4fa"
BORDER_STYLE="rounded"
MENU_STYLE="fg=#cdd6f4,bg=#313244"
SELECTED_STYLE="fg=#1e1e2e,bg=#cba6f7"

# Check config exists
if [[ ! -f "$CONFIG" ]]; then
    tmux display-message "which-key: Config not found at $CONFIG"
    exit 1
fi

# Capitalize first letter (portable)
capitalize() {
    local str="$1"
    local first="${str:0:1}"
    local rest="${str:1}"
    echo "$(echo "$first" | tr '[:lower:]' '[:upper:]')$rest"
}

# Trim leading/trailing whitespace (preserves quotes, unlike xargs)
trim() {
    local str="$1"
    str="${str#"${str%%[![:space:]]*}"}"  # trim leading
    str="${str%"${str##*[![:space:]]}"}"  # trim trailing
    echo "$str"
}

# Parse [settings] section for style overrides
parse_settings() {
    local in_settings=0
    while IFS= read -r line || [[ -n "$line" ]]; do
        [[ "$line" == "[settings]" ]] && in_settings=1 && continue
        [[ "$line" =~ ^\[.*\]$ ]] && in_settings=0
        if [[ $in_settings -eq 1 && "$line" =~ ^([^=]+)=(.+)$ ]]; then
            local key val
            key=$(trim "${BASH_REMATCH[1]}")
            val=$(trim "${BASH_REMATCH[2]}")
            case "$key" in
                title_style) TITLE_STYLE="$val" ;;
                border_style) BORDER_STYLE="$val" ;;
                menu_style) MENU_STYLE="$val" ;;
                selected_style) SELECTED_STYLE="$val" ;;
            esac
        fi
    done < "$CONFIG"
}

# Load settings before building menu
parse_settings

# Extract lines for the requested section
extract_section() {
    local section="$1"
    local in_section=0

    if [[ "$section" == "root" ]]; then
        # Root section: everything before the first [section]
        while IFS= read -r line || [[ -n "$line" ]]; do
            # Skip empty lines and comments
            [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
            # Stop at first section header
            [[ "$line" =~ ^\[.*\]$ ]] && break
            echo "$line"
        done < "$CONFIG"
    else
        # Named section: between [section] and next [section] or EOF
        while IFS= read -r line || [[ -n "$line" ]]; do
            if [[ "$line" =~ ^\[([a-zA-Z0-9_-]+)\]$ ]]; then
                if [[ "${BASH_REMATCH[1]}" == "$section" ]]; then
                    in_section=1
                    continue
                elif [[ $in_section -eq 1 ]]; then
                    break
                fi
            fi
            if [[ $in_section -eq 1 ]]; then
                # Skip empty lines and comments
                [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
                echo "$line"
            fi
        done < "$CONFIG"
    fi
}

# Build the display-menu command
build_menu() {
    local section="$1"
    local title

    if [[ "$section" == "root" ]]; then
        title="Keybindings"
    else
        title="$(capitalize "$section")"
    fi

    local -a menu_args=()
    menu_args+=("-T" "#[${TITLE_STYLE}]$title")
    menu_args+=("-x" "C" "-y" "C")
    menu_args+=("-b" "$BORDER_STYLE")
    menu_args+=("-s" "$MENU_STYLE")
    menu_args+=("-H" "$SELECTED_STYLE")

    local section_content
    section_content="$(extract_section "$section")"

    # Check if section has content
    if [[ -z "$section_content" ]]; then
        tmux display-message "which-key: Section '$section' not found"
        exit 1
    fi

    while IFS= read -r line; do
        # Separator
        if [[ "$line" == "---" ]]; then
            menu_args+=("" "" "")
            continue
        fi

        # Parse: key | description | command  OR  key | +Submenu
        if [[ "$line" =~ ^([^|]+)\|([^|]+)(\|(.*))?$ ]]; then
            local key desc cmd
            key=$(trim "${BASH_REMATCH[1]}")
            desc=$(trim "${BASH_REMATCH[2]}")
            cmd=$(trim "${BASH_REMATCH[4]:-}")

            # Escape special tmux keys
            case "$key" in
                ";"|"{"|"}"|"#"|"?") key="\\$key" ;;
            esac

            # Check if this is a submenu link (icon +Name or +Name)
            if [[ "$desc" =~ ^(.*)\+([A-Za-z]+)$ ]]; then
                local icon_prefix="${BASH_REMATCH[1]}"
                local submenu_name="${BASH_REMATCH[2]}"
                local submenu_section
                submenu_section=$(echo "$submenu_name" | tr '[:upper:]' '[:lower:]')
                local display_name="${icon_prefix}${submenu_name}"
                menu_args+=("$display_name" "$key" "run-shell '$SCRIPT_PATH $submenu_section'")
            else
                # Regular command
                menu_args+=("$desc" "$key" "$cmd")
            fi
        fi
    done <<< "$section_content"

    # Execute the menu
    tmux display-menu "${menu_args[@]}"
}

build_menu "$SECTION"
