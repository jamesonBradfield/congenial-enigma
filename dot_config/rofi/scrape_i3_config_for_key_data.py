from rofi import Rofi
import re

rofi_gui = Rofi()
key_table = {
    "Shift": "󰜷",
    "shift": "󰜷",

    "$mod": "",    "Right": "",
    "Left": "",
    "Up": "",
    "Down": "",
    "backslash": "\\",
    "space": "󱁐",
    "+": " ",
    "F1": "󱊫",
    "F2": "󱊬",
    "F3": "󱊭",
    "F4": "󱊮",
    "F5": "󱊯",
    "F6": "󱊰",
    "F7": "󱊱",
    "F8": "󱊲",
    "F9": "󱊳",
    "F10": "󱊴",
    "F11": "󱊵",
    "F12": "󱊶",
}

with open('/home/jamie/.config/i3/config') as f:
    key_desc = {
    }
    s = f.read()
    # capture a $mod+ with 0 or more words after it and 0 or more digits
    keybind = re.findall(r"\$mod\++\w*\d*\+*\w*", s)
    print("found ", len(keybind), "keybinds")
    desc = re.findall(r"^# desc:\s+\w+", s)
    print("found ", len(desc), " descriptions")

    for index, i in enumerate(keybind):
        final_key = ""
        keys = i.split("+")
        for key in keys:
            if key_table.__contains__(key):
                final_key = final_key + key_table[key] + " "
            else:
                final_key = final_key + key + " "
        print("keybind found : ", final_key)
        final_desc = ""
        final_desc = desc[index].replace("# desc: ", " ")
        key_desc[final_key] = final_desc

    for key in key_desc:
        print(key, ": ", key_desc[key])
