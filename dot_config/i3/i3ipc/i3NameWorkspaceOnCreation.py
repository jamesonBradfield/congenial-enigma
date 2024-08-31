import asyncio
from rofi import Rofi
from i3ipc import Event
from i3ipc.aio import Connection


# Define a callback function to handle window events
async def rename_new_workspaces(e, i3):
    tree = await e.get_tree()
    # if workspace is not None:
    #     last_workspace = workspace
    workspace = tree.find_focused().workspace()
    print("workspace: " + repr(workspace.name))
    r = Rofi()
    # for i in workspace.nodes:
    #     print(workspace.name + " : " + i.name)
    numbers_filled = {'1': '󰲠', '2': '󰲢', '3': '󰲤', '4': '󰲦',
                      '5': '󰲨', '6': '󰲪', '7': '󰲬', '8': '󰲮', '9': '󰲰', '0': '󰿬'}
    numbers_empty = {'1': '󰲡', '2': '󰲣', '3': '󰲥', '4': '󰲧',
                     '5': '󰲩', '6': '󰲫', '7': '󰲭', '8': '󰲯', '9': '󰲱', '0': '󰿭'}
    icons = ['', '', '󰑴', '󰠮', '󰖟']
    # TODO: we can use the code here to replace numbers with 󰲢 and 󰲣 ...    icons = ['', '', '󰑴', '󰠮', '󰖟']
    # TODO: we should also change our rofi to display 4*4 matrix of icons, this way we can have more functionality

    # TODO: we should finally setup hiding polybar numbers when not pressing $mod key
    if (len(workspace.nodes) == 0):
        new_name_index, new_name_key = r.select("icon: ", icons)
        # we are going to want to rename workspaces now
        old_name = workspace.name
        print(old_name)
        if icons[new_name_key] is not None:
            await workspace.command(f'rename workspace {workspace.name} to {icons[new_name_key]} {numbers_filled[old_name]}')


async def penor():
    i3 = await Connection().connect()
    # Subscribe to window events this sends a
    i3.on(Event.WORKSPACE_FOCUS,  rename_new_workspaces)

    await i3.main()
if __name__ == '__main__':
    asyncio.run(penor())

