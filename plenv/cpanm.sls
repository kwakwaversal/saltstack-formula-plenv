{% from "plenv/map.jinja" import map with context %}

include:
  - plenv.install

{%- for name, args in plenv.users.items() %}
  {%- set versions = salt["pillar.get"]("plenv:users:" + name + ":perl:versions", plenv.perl.versions) %}
  {%- for version in versions %}
plenv-install-cpamn-{{ version }}-{{ name }}:
  cmd.run:
    - unless: {{ plenv.bin }} which cpanm
    - name: {{ plenv.bin }} install-cpanm
    - runas: {{ args.user }}
    - env:
      - PLENV_VERSION: {{ version }}
  {%- endfor %}
{%- endfor %}
