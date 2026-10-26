#!/bin/bash
# Codespaces phone-free test stream - video loop to YouTube RTMP
# Usage in Codespace terminal (key is NOT in this file):
#   read -s KEY
#   export KEY
#   nohup ./stream.sh > stream.log 2>&1 &
# Stop: pkill ffmpeg  (or stop the Codespace)
# After the test, reset the stream key in YouTube Studio.
while true; do
  ffmpeg -re -stream_loop -1 -i video.mp4 \
    -vf scale=720:-2 \
    -c:v libx264 -preset superfast \
    -b:v 2000k -maxrate 2000k -bufsize 4000k \
    -pix_fmt yuv420p -g 60 -r 30 \
    -c:a aac -b:a 128k -ar 44100 \
    -f flv "rtmp://a.rtmp.youtube.com/live2/$KEY"
  echo "Stream stopped, restarting in 5 seconds..."
  sleep 5
done
