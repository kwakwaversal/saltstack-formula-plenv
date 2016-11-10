{% from "plenv/map.jinja" import plenv with context %}

include:
  - plenv.install

{%- for name, args in plenv.users.items() %}
  {%- set version = salt["pillar.get"]("plenv:users:" + name + ":perl:global", plenv.perl.global) %}
  {%- if version %}
plenv-global-{{ name }}:
  cmd.run:
    - onlyif: {{ plenv.bin }} versions | grep {{ version }}
    - name: {{ plenv.bin }} global {{ version }}
    - runas: {{ args.user }}
    - require:
      - cmd: plenv-install-{{ version }}-{{ name }}
  {%- endif %}
{%- endfor %}
