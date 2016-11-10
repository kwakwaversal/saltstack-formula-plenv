{% from "plenv/map.jinja" import plenv with context %}

plenv-clone:
  pkg.installed:
    - names:
      - git

{%- for name, args in plenv.users.items() %}
plenv-clone-{{ name }}:
  cmd.run:
    - unless: test -d ~/.plenv
    - name: git clone {{ salt["pillar.get"]("plenv:users:" + name + ":repository", plenv.repository) }} ~/.plenv
    - runas: {{ args.user }}
{%- endfor %}
