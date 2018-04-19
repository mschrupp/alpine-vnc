# alpine-vnc
Run xfce on alpine using xvfb, open VNC server


```
# build container (set PW!)
docker build -t desktop --build-arg PW= .

# run it
docker container run -d -p 5900:5900 --cap-add SYS_ADMIN --device /dev/fuse -v /storage:/storage_encrypted --name desktop desktop

# change password now

```