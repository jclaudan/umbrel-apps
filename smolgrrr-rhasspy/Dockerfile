FROM rhasspy/rhasspy:2.5.0-pre

USER 0

RUN useradd -m --uid $UID pacat

COPY asoundrc /home/pacat/.asoundrc

RUN apt-get update && apt-get install -y pulseaudio
USER 1001
