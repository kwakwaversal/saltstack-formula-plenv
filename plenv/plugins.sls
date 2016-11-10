{% from "plenv/map.jinja" import plenv with context %}

include:
  - plenv.clone

{%- for name, args in plenv.users.items() %}
  {%- for plugin, gitrepo in plenv.plugins.items() %}
plenv-plugins-{{ plugin }}-{{ name }}:
  cmd.run:
    - unless: test -d ~/.plenv/plugins/{{ plugin }}
    - name: git clone {{ gitrepo }} ~/.plenv/plugins/{{ plugin }}
    - runas: {{ args.user }}
  {%- endfor %}
{%- endfor %}
