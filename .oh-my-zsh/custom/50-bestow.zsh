
readonly STOW_DIR="$HOME/stow"

bestow() {
    xstow -no-curses -d "$STOW_DIR" -ire "^(README.md|.git|\.#.+|.+~)$" $(cd $STOW_DIR; echo *)
}
