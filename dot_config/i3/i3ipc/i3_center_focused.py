import i3ipc
import subprocess
import time

# Initialize connection to the i3 window manager
i3 = i3ipc.Connection()


def center_window():
    # Get the focused window
    focused = i3.get_tree().find_focused()

    # Get screen dimensions
    screen_width = focused.rect.width
    screen_height = focused.rect.height

    # Calculate the center position for the window
    window_width = focused.rect.width
    window_height = focused.rect.height
    center_x = (screen_width - window_width) // 2
    center_y = (screen_height - window_height) // 2

    # Move the window to the center of the screen
    subprocess.run(["xdotool", "windowmove", str(
        focused.window), str(center_x), str(center_y)])

# Listen for window focus events


def on_window_focus(i3, event):
    center_window()


# Subscribe to window focus events
i3.on("window::focus", on_window_focus)

# Center the currently focused window initially
center_window()

# Start the event loop
i3.main()
