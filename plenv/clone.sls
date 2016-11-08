{% from "plenv/map.jinja" import map with context %}

plenv-clone:
  pkg.installed:
    - names:
      - git
  cmd.run:
    - unless: test -d ~/.plenv
    - name: git clone {{ map.repository }} ~/.plenv
    - user: {{ map.user }}
