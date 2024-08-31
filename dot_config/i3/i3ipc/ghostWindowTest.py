import i3ipc

i3 = i3ipc.Connection()
i3.on('window::focus', get_con_id)


