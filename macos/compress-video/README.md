# Compress Video — Finder Quick Action

Right-click a video in Finder → **Quick Actions → Compress Video**. Writes
`<name>-compressed.mp4` next to the original (non-destructive). Shows a live
progress bar and a notification when finished. Also works as a drag-and-drop
app or by double-clicking it.

## Encoding

ffmpeg with `libx264 -crf 23 -preset medium` (H.264, `+faststart`), AAC audio.
Chosen for screen recordings: ~3× faster than software HEVC at roughly the same
size, and far better than hardware (VideoToolbox) encoders, which produce huge
files on text-heavy screen content.

To change quality/speed, edit `CompressVideo.applescript.tmpl` and re-run
`script/install_quick_actions` (or `script/setup`):
- `-crf 23` — lower = better/bigger, higher = smaller/softer
- `-preset medium` — `veryfast` (faster, bigger) … `slow` (slower, smaller)
- smaller files, slower: `-c:v libx265 -crf 28 -tag:v hvc1`

## Pieces

- `CompressVideo.applescript.tmpl` — app source; `__FFMPEG__`/`__FFPROBE__` are
  filled in at install time. Compiled to `~/Applications/Compress Video.app`.
- `Compress Video.workflow/` — the Finder Quick Action; symlinked into
  `~/Library/Services/`. It just hands selected files to the app.

Installed by `script/install_quick_actions` (called from `script/setup` on macOS).
Requires `ffmpeg` (already in the `Brewfile`).
