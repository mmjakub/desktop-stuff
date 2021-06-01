# desktop-stuff
 useful scripts and config snippets
 
## active_window_titlebar.sh
Minimalistic titlebar for [i3](https://i3wm.org/) using [i3bar protocol](https://i3wm.org/docs/i3bar-protocol.html)

I recommend using it like this in config: 
```
bar {  
 status_command act_wnd_titlebar.sh  
 mode hide  
 position top  
}
```

It updates when bar is shown on every `$mod` press. You can also add it after focus and workspace switch binds like so

```
set $update_bar exec active_window_titlebar.sh
...
bindsym ... ; $update_bar
```

## mp4tag.py
Write MP4 tags using mutagen.
It expects to be launched from directory named `"ARTIST - ALBUM (DATE)"` containing files `TRACK_NUMBER.TITLE.m4a` and `cover.jpg`
