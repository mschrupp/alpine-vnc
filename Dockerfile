FROM alpine:edge

ARG PW

RUN apk --update --no-cache add  supervisor bash x11vnc shadow firefox-esr sudo xvfb \
	exo xfce4-whiskermenu-plugin gtk-xfce-engine thunar numix-themes-xfwm4 xfce4-panel xfce4-session xfce4-settings xfce4-terminal xfconf xfdesktop xfwm4 xsetroot \
	ttf-dejavu numix-themes-gtk2 numix-themes-gtk3 adwaita-icon-theme

RUN useradd -m -s /bin/bash max

RUN echo "max:$PW" | chpasswd

RUN echo "max ALL=(ALL) ALL" >> /etc/sudoers

RUN mkdir -p /etc/supervisor/conf.d

RUN x11vnc -storepasswd $PW /etc/vncpw && chmod 444 /etc/vncpw

RUN rm -rf /apk /tmp/* /var/cache/apk/*

ADD supervisord.conf /etc/supervisor/conf.d/

EXPOSE 5900
WORKDIR /home/max

CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
