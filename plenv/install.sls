{% from "plenv/map.jinja" import map with context %}

plenv-install:
  pkg.installed:
    - names:
      - build-essential
      - curl
  cmd.run:
    - unless: {{ map.plenv }} versions |grep {{ map.perl.version }}
    - name: {{ map.plenv }} install {{ map.perl.version }}
    - user: {{ map.user }}
