
set -euo pipefail

if ! command -v fzf &> /dev/null; then
    echo "Error: fzf could not be found." >&2
    echo "Please install it first: brew install fzf" >&2
    exit 1
fi

if ! command -v brew &> /dev/null; then
    echo "Error: brew command could not be found." >&2
    echo "Please ensure Homebrew is installed and in your PATH." >&2
    exit 1
fi

main_interactive_loop() {
    local current_search_term="$1"
    local packages=""
    local selected_package=""

    while true; do
        if [ -z "$current_search_term" ]; then
            local new_search_input
            echo
            read -r -p "Enter Brew search term (or press Enter to quit): " new_search_input
            if [ -z "$new_search_input" ]; then
                echo "No search term provided. Quitting."
                return 0
            fi
            current_search_term="$new_search_input"
        fi

        echo
        echo "Searching for '$current_search_term'..."

        packages=$( (brew search --formulae "$current_search_term" 2>/dev/null; brew search --casks "$current_search_term" 2>/dev/null) |
                     grep -v '^==>' |
                     grep . |
                     sort -u )

        if [ -z "$packages" ]; then
            echo "No packages found matching '$current_search_term'."
            # No packages found. Proceed directly to the main options menu.
        else
            # Packages found. Enter the fzf loop for selection.
            # This loop runs once per selection (install) or if Esc is pressed in fzf.
            # After one selection/install, it breaks to the main menu.
            while true; do
                selected_package=$(echo "$packages" | fzf \
                    --prompt="Select ('$current_search_term' results | Enter: INSTALL | Esc: main menu): " \
                    --height="70%" \
                    --layout=reverse \
                    --border \
                    --preview-window='right:60%:wrap' \
                    --header "Search: '$current_search_term'. ↑↓ to navigate. Enter to INSTALL. Preview: 'brew info'." \
                    --preview="echo 'Loading info for {}...' && brew info {} 2>/dev/null || echo 'No detailed info or cask not tapped.'" \
                    --exit-0)

                if [ -z "$selected_package" ]; then
                    break
                fi

                echo
                echo "-----------------------------------------------------"
                echo "Attempting to install: $selected_package (from search '$current_search_term')"
                echo "-----------------------------------------------------"
                
                if brew install "$selected_package"; then
                    echo -e "\n'$selected_package' installed successfully!"
                else
                    echo -e "\nFailed to install '$selected_package'. It might already be installed or another issue occurred." >&2
                fi
                echo

                break
            done
        fi

        echo
        echo "What would you like to do next?"
        echo "1. Search again for '$current_search_term' (refresh results)"
        echo "2. Search for a new app"
        echo "3. Quit"

        local choice

        while true; do
            read -r -p "Enter your choice (1-3): " choice
            case "$choice" in
                1)
                   echo "Preparing to search again for '$current_search_term'..."
                   break
                   ;;
                2)
                   current_search_term=""
                   echo "Preparing to search for a new app..."
                   break
                   ;;
                3)
                   echo "Quitting."
                   return 0
                   ;;
                *) echo "Invalid choice. Please enter 1, 2, or 3." >&2 ;;
            esac
        done
    done
}

initial_search_term="${1-}"

main_interactive_loop "$initial_search_term"

exit 0