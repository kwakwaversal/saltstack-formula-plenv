{% from "plenv/map.jinja" import map with context %}

plenv-global:
  cmd.run:
    - onlyif: {{ map.plenv }} versions |grep {{ map.perl.version }}
    - name: {{ map.plenv }} global {{ map.perl.version }}
    - user: {{ map.user }}
    - require:
      - cmd: plenv-install
