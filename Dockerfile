FROM registry.fedoraproject.org/fedora-minimal:37
RUN microdnf install -y --setopt install_weak_deps=0 busybox spice-html5 python3-websockify novnc weston labwc sway wayvnc dbus-daemon procps-ng foot wofi bemenu google-noto-naskh-arabic-fonts dejavu-fonts-all ; microdnf clean all 

RUN mkdir /opt/busybox; \
    /sbin/busybox --install -s /opt/busybox
ENV PATH=/usr/share/Modules/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/opt/busybox
RUN cp /usr/share/weston/background.png /usr/share/backgrounds/default.png ; \
    busybox adduser -D app ; \
    busybox passwd -l app ; \
    mkdir -p /home/app/tmp ; busybox chown app:app /home/app/tmp
ADD weston-terminal.desktop /usr/share/applications/weston-terminal.desktop
ADD sway /etc/sway/config.d/sway
ADD labwc /etc/xdg/labwc

USER app
ENV SHELL=/bin/bash
ENV PATH=/home/app/.local/bin:/home/app/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/busybox
ENV XDG_RUNTIME_DIR=/home/app/tmp
ENV WLR_BACKENDS=headless
ENV WLR_LIBINPUT_NO_DEVICES=1
ENV WAYLAND_DISPLAY=wayland-1

ADD start.sh /start.sh

EXPOSE 5900
EXPOSE 8080


ENTRYPOINT ["/start.sh"]



