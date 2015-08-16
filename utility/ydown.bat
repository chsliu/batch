youtube-dl -c -i -f "bestvideo[height<=?480]+bestaudio/best" -o "%%(title)s (%%(height)sp).%%(ext)s" "%1"

cmd /u /c youtube-dl -c -i -f "bestvideo[height<=?480]+bestaudio/best" -o "%%(title)s (%%(height)sp).%%(ext)s" "%1"
