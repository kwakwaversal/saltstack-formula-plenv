# saltstack-formula-plenv
Install [plenv](https://github.com/tokuhirom/plenv) and [Perl](http://perldoc.perl.org/)
http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html

## Description
plenv will be installed in ~/.plenv. This is assumed when cloning the main
repository, when cloning plenv-related plugins, and conditional checks for
certain salt states. It's not currently possible to change the default
installation folder without updating the whole formula.

## Available states

  - [plenv](#plenv)
  - [plenv.clone](#plenv.clone)
  - [plenv.global](#plenv.global)
  - [plenv.global-packages](#plenv.global-packages)
  - [plenv.install](#plenv.install)
  - [plenv.plugins](#plenv.plugins)
  - [plenv.profile](#plenv.profile)

## Basic pillar
Below is a basic pillar for the user `vagrant`. N.B., the user must exist on the
system you're salting.

```yaml
plenv:
  # The version of perl to be installed for all users. N.B., this can be
  # overridden per user.
  perl:
    packages: []
    versions:
      - 5.22.0

  users:
    vagrant:
      user: vagrant
      group: vagrant
      perl:
        packages_install_options: -q --cascade-search --mirror ftp://mirror.bytemark.co.uk/CPAN/ --mirror http://cpan.org
        packages:
          - Carton
        versions:
          - 5.24.0
```
