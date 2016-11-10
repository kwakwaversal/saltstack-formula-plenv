{% from "plenv/map.jinja" import plenv with context %}

{%- for name, args in plenv.users.items() %}
plenv-profile-exists-{{ name }}:
  file.managed:
    {%- if args.user == 'root' %}
    - name: /root/{{ salt["pillar.get"]("plenv:users:" + name + ":profile", plenv.profile) }}
    {%- else %}
    - name: /home/{{ args.user }}/{{ salt["pillar.get"]("plenv:users:" + name + ":profile", plenv.profile) }}
    {%- endif %}
    - user: {{ args.user }}
    - group: {{ args.user }}
    - mode: 644

plenv-profile-append-{{ name }}:
  file.append:
    {%- if args.user == 'root' %}
    - name: /root/{{ salt["pillar.get"]("plenv:users:" + name + ":profile", plenv.profile) }}
    {%- else %}
    - name: /home/{{ args.user }}/{{ salt["pillar.get"]("plenv:users:" + name + ":profile", plenv.profile) }}
    {%- endif %}
    - source: salt://plenv/files/.bash_profile
{%- endfor %}
