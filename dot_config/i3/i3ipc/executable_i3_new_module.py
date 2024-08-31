import asyncio
from i3ipc import Event
from i3ipc.aio import Connection


async def update_focused(e, i3):
    tree = await e.get_tree()
    focused_workspace = tree.find_focused().workspace()


# async def reorder_by_name(e, i3):
#     tree = await e.get_tree()
    # focused_workspace = tree.find_focused().workspace()
    # workspaces = tree.workspaces()
    # if (len(workspace.nodes) == 0):


async def penor():
    i3 = await Connection().connect()
    # Subscribe to window events this sends a
    i3.on(Event.WORKSPACE_FOCUS,  update_focused)
    # i3.on(Event.WORKSPACE_INIT, reorder_by_name)

    await i3.main()
if __name__ == '__main__':
    asyncio.run(penor())
