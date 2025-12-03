#!/usr/bin/env bash
# which-key-generate.sh: Generate which-key.conf from current tmux bindings
# Usage: which-key-generate.sh [output-file]
#
# Parses tmux prefix bindings and generates a config file with
# human-readable descriptions, Nerd Font icons, and organized sections.

OUTPUT="${1:-/dev/stdout}"

# Icon mappings
icon_reload=$'\uf021'
icon_window=$'\uf2d0'
icon_pane=$'\uf00a'
icon_session=$'\uf0e8'
icon_split=$'\uf0db'
icon_new=$'\uf055'
icon_kill=$'\uf00d'
icon_nav=$'\uf061'
icon_nav_left=$'\uf060'
icon_nav_up=$'\uf062'
icon_nav_down=$'\uf063'
icon_edit=$'\uf044'
icon_search=$'\uf002'
icon_copy=$'\uf0c5'
icon_list=$'\uf03a'
icon_zoom=$'\uf065'
icon_detach=$'\uf08b'
icon_refresh=$'\uf0e2'
icon_swap=$'\uf0dc'
icon_mark=$'\uf024'
icon_clock=$'\uf017'
icon_info=$'\uf05a'

# Categorize a command into a section
# Returns: root, windows, panes, sessions, buffers, or misc
categorize_command() {
    local cmd="$1"
    case "$cmd" in
        # Split goes in root (common action) - check before *-window*
        split-window*)
            echo "root" ;;

        # Pane commands
        *-pane*|select-pane*|resize-pane*|swap-pane*|break-pane*|display-panes*)
            echo "panes" ;;

        # Window commands
        *-window*|select-window*|next-window*|previous-window*|last-window*|swap-window*)
            echo "windows" ;;

        # Session commands
        *-session*|*-client*|choose-tree*|choose-client*)
            echo "sessions" ;;

        # Buffer/copy commands
        *-buffer*|copy-mode*|paste-buffer*)
            echo "buffers" ;;

        # Everything else in root
        *)
            echo "root" ;;
    esac
}

# Generate description and icon for a command
describe_command() {
    local cmd="$1"

    case "$cmd" in
        source-file*|"source "*) echo "$icon_reload Reload config" ;;
        split-window*-h*) echo "$icon_split Split right" ;;
        split-window*-v*|split-window*) echo "$icon_split Split down" ;;
        new-window*) echo "$icon_new New window" ;;
        kill-window) echo "$icon_kill Kill window" ;;
        *confirm*kill-window*) echo "$icon_kill Kill window (confirm)" ;;
        next-window*) echo "$icon_nav Next window" ;;
        previous-window*|prev-window*) echo "$icon_nav_left Prev window" ;;
        last-window*) echo "$icon_refresh Last window" ;;
        select-window*-t*:=*)
            local num="${cmd##*:=}"
            num="${num%%\}*}"
            num="${num%%\"*}"
            echo "$icon_window Window $num" ;;
        select-window*) echo "$icon_window Select window" ;;
        *rename-window*) echo "$icon_edit Rename window" ;;
        *move-window*) echo "$icon_nav Move window" ;;
        *swap-window*) echo "$icon_swap Swap window" ;;
        kill-pane*) echo "$icon_kill Kill pane" ;;
        select-pane*-L*) echo "$icon_nav_left Pane left" ;;
        select-pane*-R*) echo "$icon_nav Pane right" ;;
        select-pane*-U*) echo "$icon_nav_up Pane up" ;;
        select-pane*-D*) echo "$icon_nav_down Pane down" ;;
        select-pane*:.+*) echo "$icon_nav Next pane" ;;
        select-pane*-m*) echo "$icon_mark Mark pane" ;;
        select-pane*) echo "$icon_pane Select pane" ;;
        last-pane*) echo "$icon_refresh Last pane" ;;
        resize-pane*-Z*) echo "$icon_zoom Toggle zoom" ;;
        resize-pane*-L*) echo "$icon_nav_left Resize left" ;;
        resize-pane*-R*) echo "$icon_nav Resize right" ;;
        resize-pane*-U*) echo "$icon_nav_up Resize up" ;;
        resize-pane*-D*) echo "$icon_nav_down Resize down" ;;
        swap-pane*-U*) echo "$icon_swap Swap up" ;;
        swap-pane*-D*) echo "$icon_swap Swap down" ;;
        swap-pane*) echo "$icon_swap Swap pane" ;;
        break-pane*) echo "$icon_window Break pane" ;;
        *display-panes*) echo "$icon_pane Display panes" ;;
        detach-client*|detach*) echo "$icon_detach Detach" ;;
        switch-client*-p*) echo "$icon_nav_left Prev session" ;;
        switch-client*-n*) echo "$icon_nav Next session" ;;
        switch-client*-l*) echo "$icon_refresh Last session" ;;
        switch-client*) echo "$icon_session Switch session" ;;
        *rename-session*) echo "$icon_edit Rename session" ;;
        *new-session*) echo "$icon_new New session" ;;
        choose-tree*) echo "$icon_session Choose tree" ;;
        choose-client*) echo "$icon_session Choose client" ;;
        copy-mode*) echo "$icon_copy Copy mode" ;;
        paste-buffer*) echo "$icon_copy Paste" ;;
        list-buffers*) echo "$icon_list List buffers" ;;
        choose-buffer*) echo "$icon_list Choose buffer" ;;
        delete-buffer*) echo "$icon_kill Delete buffer" ;;
        show-messages*) echo "$icon_info Show messages" ;;
        display-message*) echo "$icon_info Display info" ;;
        clock-mode*) echo "$icon_clock Clock" ;;
        list-keys*) echo "$icon_search List keys" ;;
        command-prompt*) echo "$icon_edit Command prompt" ;;
        refresh-client*) echo "$icon_reload Refresh" ;;
        *run-shell*which-key*) echo "$icon_search Which-key" ;;
        *) echo "${cmd%% *}" ;;
    esac
}

# Unescape tmux key notation
unescape_key() {
    local key="$1"
    key="${key#\\}"
    echo "$key"
}

# Temp files for sections
tmp_root=$(mktemp)
tmp_windows=$(mktemp)
tmp_panes=$(mktemp)
tmp_sessions=$(mktemp)
tmp_buffers=$(mktemp)

trap "rm -f $tmp_root $tmp_windows $tmp_panes $tmp_sessions $tmp_buffers" EXIT

# Parse all bindings and categorize
tmux list-keys -T prefix | while read -r line; do
    if [[ "$line" =~ ^bind-key[[:space:]]+-T[[:space:]]+prefix[[:space:]]+([^[:space:]]+)[[:space:]]+(.+)$ ]]; then
        raw_key="${BASH_REMATCH[1]}"
        cmd="${BASH_REMATCH[2]}"

        # Skip which-key's own binding and complex display-menu commands
        [[ "$cmd" == *"which-key"* ]] && continue
        [[ "$cmd" == display-menu* ]] && continue

        key=$(unescape_key "$raw_key")
        desc=$(describe_command "$cmd")
        category=$(categorize_command "$cmd")

        line_out="$key | $desc | $cmd"

        case "$category" in
            root) echo "$line_out" >> "$tmp_root" ;;
            windows) echo "$line_out" >> "$tmp_windows" ;;
            panes) echo "$line_out" >> "$tmp_panes" ;;
            sessions) echo "$line_out" >> "$tmp_sessions" ;;
            buffers) echo "$line_out" >> "$tmp_buffers" ;;
        esac
    fi
done

# Generate the config
generate_config() {
    cat << 'HEADER'
# tmux which-key configuration
# Auto-generated - review and customize as needed
#
# Format: key | description | command
#         key | +Submenu Name (links to [sectionname])
#         --- (separator)

# Root menu - shown on prefix + Space
HEADER

    # Root items
    if [[ -s "$tmp_root" ]]; then
        cat "$tmp_root"
    fi

    # Submenu links
    echo "---"
    [[ -s "$tmp_windows" ]] && printf 'w | %s +Windows\n' "$icon_window"
    [[ -s "$tmp_panes" ]] && printf 'p | %s +Panes\n' "$icon_pane"
    [[ -s "$tmp_sessions" ]] && printf 's | %s +Sessions\n' "$icon_session"
    [[ -s "$tmp_buffers" ]] && printf 'b | %s +Buffers\n' "$icon_copy"

    # Windows section
    if [[ -s "$tmp_windows" ]]; then
        echo ""
        echo "[windows]"
        cat "$tmp_windows"
    fi

    # Panes section
    if [[ -s "$tmp_panes" ]]; then
        echo ""
        echo "[panes]"
        cat "$tmp_panes"
    fi

    # Sessions section
    if [[ -s "$tmp_sessions" ]]; then
        echo ""
        echo "[sessions]"
        cat "$tmp_sessions"
    fi

    # Buffers section
    if [[ -s "$tmp_buffers" ]]; then
        echo ""
        echo "[buffers]"
        cat "$tmp_buffers"
    fi

    cat << 'FOOTER'

[settings]
# Catppuccin Mocha theme (defaults - customize as needed)
# title_style = align=centre,bold,fg=#89b4fa
# border_style = rounded
# menu_style = fg=#cdd6f4,bg=#313244
# selected_style = fg=#1e1e2e,bg=#cba6f7
FOOTER
}

# Run
if [[ "$OUTPUT" == "/dev/stdout" ]]; then
    generate_config
else
    generate_config > "$OUTPUT"
    echo "Generated: $OUTPUT"
fi
