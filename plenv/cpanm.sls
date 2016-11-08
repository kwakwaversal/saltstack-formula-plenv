{% from "plenv/map.jinja" import map with context %}

plenv-cpanm:
  cmd.run:
    - unless: PLENV_VERISON={{ map.perl.version }} {{ map.plenv }} which cpanm
    - name: PLENV_VERISON={{ map.perl.version }} {{ map.plenv }} install-cpanm
    - user: {{ map.user }}
    - require:
      - cmd: plenv-install
