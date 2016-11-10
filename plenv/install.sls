{% from "plenv/map.jinja" import plenv with context %}

include:
  - plenv.clone
  - plenv.plugins
  - plenv.profile

plenv-install:
  pkg.installed:
    - names:
      - build-essential
      - curl

{%- for name, args in plenv.users.items() %}
  {%- set versions = salt["pillar.get"]("plenv:users:" + name + ":perl:versions", plenv.perl.versions) %}
  {%- for version in versions %}
plenv-install-{{ version }}-{{ name }}:
  cmd.run:
    - unless: {{ plenv.bin }} versions | grep {{ version }}
    - name: {{ plenv.bin }} install {{ version }}
    - runas: {{ args.user }}
  {%- endfor %}
{%- endfor %}
