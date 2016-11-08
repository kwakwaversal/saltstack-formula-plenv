{% from "plenv/map.jinja" import map with context %}

plenv-plugins:
  pkg.installed:
    - names:
      - git
  cmd.run:
    - unless: test -d ~/.plenv/plugins/perl-build
    - name: git clone git://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build
    - user: {{ map.user }}
