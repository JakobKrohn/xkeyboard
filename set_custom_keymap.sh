#!/bin/bash
set -x
echo "Setting custom keymap ... "
# Fetch original keymap
xkbcomp $DISPLAY ~/xkeyboard/unmodified_xkeymap.xkb && \
# Copy to new working file 
cp ~/xkeyboard/unmodified_xkeymap.xkb ~/xkeyboard/custom_keymap.xkb && \
# Create patch file for custom caps lock
diff -u ~/xkeyboard/custom_keymap.xkb ~/xkeyboard/add_custom_capslock_to_xkb_types.xkb > ~/xkeyboard/custom_caps_lock.patch

# Apply path to original xkb file
patch -u -b ~/xkeyboard/custom_keymap.xkb -i ~/xkeyboard/custom_caps_lock.patch && \
# Load new custom capslock type
xkbcomp ~/xkeyboard/custom_keymap.xkb $DISPLAY && \
# Set shortcuts patch
diff -u ~/xkeyboard/custom_keymap.xkb ~/xkeyboard/custom_capslock_shortcuts.xkb > ~/xkeyboard/shortcuts.patch

# apply patch
patch -u -b ~/xkeyboard/custom_keymap.xkb -i ~/xkeyboard/shortcuts.patch && \
xkbcomp ~/xkeyboard/custom_keymap.xkb $DISPLAY && \
echo "Successfully created custom keymap!" || echo "FAILED!"

set -v
