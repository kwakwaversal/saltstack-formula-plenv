{% from "plenv/map.jinja" import map with context %}

plenv-profile-exists:
  file.managed:
    - name: /home/{{ map.user }}/.bash_profile
    - user: {{ map.user }}
    - group: {{ map.user }}
    - mode: 644

plenv-profile-append:
  file.append:
    - name: /home/{{ map.user }}/.bash_profile
    - source: salt://plenv/files/.bash_profile
