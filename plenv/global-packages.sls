{% from "plenv/map.jinja" import plenv with context %}

include:
  - plenv.install
  - plenv.cpanm

{%- for name, args in plenv.users.items() %}
  {%- set npm_install_options = salt["pillar.get"]("plenv:users:" + name + ":perl:packages_install_options", plenv.perl.packages_install_options)  %}
  {%- set versions = salt["pillar.get"]("plenv:users:" + name + ":perl:versions", plenv.perl.versions) %}
  {%- for version in versions %}
    {%- set pkgs = salt["pillar.get"]("plenv:users:" + name + ":perl:packages", plenv.perl.packages) %}
    {%- for pkg in pkgs %}
plenv-global-pkgs-{{ version }}-{{ pkg }}-{{ name }}:
  cmd.run:
    - unless: {{ plenv.bin }} exec npm list -g | grep " {{ pkg }}@"
    - name: |
        {{ plenv.bin }} exec npm install -g {{ npm_install_options }} {{ pkg }}
        {{ plenv.bin }} rehash
    - runas: {{ args.user }}
    - env:
      - NDENV_VERSION: {{ version }}
    {%- endfor %}
  {%- endfor %}
{%- endfor %}
