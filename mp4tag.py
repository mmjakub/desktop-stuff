#!/usr/bin/env python3
from mutagen.mp4 import MP4, MP4Cover
from pathlib import Path
import re

album_dir = Path('.')
artist, album, date = re.fullmatch('(.+) - (.+) \((\d{4})\)', album_dir.resolve().name).groups()

tracks = [p.name for p in album_dir.glob('*.m4a')]
total_tracks = len(tracks)

with open('cover.jpg', 'rb') as f:
    cover = MP4Cover(f.read())

for track in tracks:
    no, title = re.fullmatch('(\d{2})\.(.+)\.m4a', track).groups()
    track_no = int(no)
    mp4 = MP4(track)
    mp4.tags['\xa9nam'] = title
    mp4.tags['\xa9ART'] = artist
    mp4.tags['\xa9alb'] = album
    mp4.tags['\xa9day'] = date
    mp4.tags['trkn'] = ((track_no, total_tracks),)
    mp4.tags['covr'] = [cover]
    mp4.save()
