#!/home/jamie/.config/i3/i3ipc/bin/python3.12
import i3ipc


def resize_focused(i3, e):
    if e.container.window_class in ['Brave-browser',  'Alacritty']:
        e.container.command('resize set 66 ppt 60 ppt')

def resize_unfocused(i3, e):
    if e.container.window_class in ['Brave-browser',  'Alacritty']:
        e.container.command('resize set 10 ppt 10 ppt')


i3 = i3ipc.Connection()
# i3.on('window::focus', resize_focused)
i3.on('window::unfocus', resize_unfocused)
i3.main()

