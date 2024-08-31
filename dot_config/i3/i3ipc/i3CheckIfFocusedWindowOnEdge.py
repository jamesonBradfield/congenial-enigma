import i3ipc
import asyncio
import subprocess
import pprint
import os
from i3ipc import Event
from i3ipc.aio import Connection


def get_resolution():
    try:
        # Run xrandr command to get current display information
        output = subprocess.check_output(['xrandr']).decode('utf-8')

        # Find the line that contains current resolution information
        for line in output.splitlines():
            if '*+' in line:  # Look for the line marked with '*+'
                resolution = line.split()[0]
                print("resolution:", resolution)
                return resolution

    except subprocess.CalledProcessError as e:
        print(f"Error: {e}")

    return None


def check_right(rect):
    return (rect.x + rect.width) == i3_usable_desktop_width or rect.x + rect.width == i3_usable_desktop_width


def check_left(rect):
    return rect.x == padding


def check_top(rect):
    return rect.y == padding + polybar_real_estate


def check_bottom(rect):
    return (rect.y + rect.height) - polybar_real_estate  == i3_usable_desktop_height


 # the tree structure displays horizontal children as the first level of nodes in a workspace (see https://i3wm.org/docs/userguide.html#_the_tree_consists_of_containers)
async def count_containers_horizontally(i3,e):
    horizontal_count = 0
    tree = await i3.get_tree()
    workspace= tree.find_focused().workspace()
    for node in workspace.nodes:
        horizontal_count += 1


async def count_containers_vertically(i3,e):
    vertical_count = 0
    last_vertical_count = 0
    tree = await i3.get_tree()
    workspace= tree.find_focused().workspace()
    await find_splitv_containers(workspace)


async def find_splitv_containers(node):
    for n in node.nodes:
        # still unsure about which one is vertical and which one is horizontal
        print(n)
        if n.layout == str('splitv'):
            await find_splitv_containers(n)




# Define a callback function to handle window events
async def check_edges(i3, e): 
    if e.change == 'focus' and e.container:
        # Access the rect attribute to get window dimensions
        rect = e.container.rect
        if (check_right(rect)):
            print(f"Window {e.container.window_title} is on the right edge")
        if (check_left(rect)):
            print(f"Window {e.container.window_title} is on the left edge")
        if (check_top(rect)):
            print(f"Window {e.container.window_title} is on the top edge")
        if (check_bottom(rect)):
            print(f"Window {e.container.window_title} is on the bottom edge")


async def main():
    i3 = await Connection().connect()
    # Subscribe to window events this sends a 
    i3.on(Event.WINDOW_FOCUS,  check_edges)
    i3.on(Event.WINDOW_CLOSE,  count_containers_horizontally)
    i3.on(Event.WINDOW_MOVE,  count_containers_horizontally)
    i3.on(Event.WINDOW_NEW,  count_containers_horizontally)
    i3.on(Event.WINDOW_FULLSCREEN_MODE,  count_containers_horizontally)
    i3.on(Event.WINDOW_CLOSE,  count_containers_vertically)
    i3.on(Event.WINDOW_MOVE,  count_containers_vertically)
    i3.on(Event.WINDOW_NEW,  count_containers_vertically)
    i3.on(Event.WINDOW_FULLSCREEN_MODE,  count_containers_vertically)

    await i3.main()

horizontal_count = 0
desktop_resoultion = get_resolution()
desktop_width,desktop_height = desktop_resoultion.split('x')
padding = 60
# this polybar_real_estate is found by (padding (gaps.outer) - desktop_height - i3 window size
polybar_real_estate = 50
i3_usable_desktop_width = int(desktop_width) - padding
i3_usable_desktop_height = int(desktop_height) - padding - polybar_real_estate


if __name__ == '__main__':
    asyncio.run(main())


