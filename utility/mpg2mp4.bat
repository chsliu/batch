
set ffmpeg="D:\Users\sita\PortableApps\kmttg_v1.1i\ffmpeg\ffmpeg.exe"


%ffmpeg% -y -i %1 -threads 1 -vcodec libx264 -level 30 -subq 6 -me_range 16 -qmin 15 -qmax 20 -g 300 -s 320x240 -r 29.97 -b 700k -maxrate 1000k -acodec aac -strict -2 -ac 2 -ab 128k -ar 48000 -f mp4 "%~n1.mp4" 

